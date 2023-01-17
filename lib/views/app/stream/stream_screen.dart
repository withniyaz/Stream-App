import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_app/components/Buttons/iconsvg_button.dart';
import 'package:stream_app/components/Buttons/solid_button.dart';
import 'package:stream_app/constants/app_constants.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';
import 'package:stream_app/services/api_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class StreamScreen extends StatefulWidget {
  final Stream stream;
  const StreamScreen({Key? key, required this.stream}) : super(key: key);

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  late Stream stream;
  final io.Socket _socket = io.io(socketFullUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  // Initializations and Instances
  final ApiService _apiProvider = ApiService();
  RtmpConnection? _connection;
  RtmpStream? _stream;
  bool _recording = false;
  String _mode = "publish";
  CameraPosition currentPosition = CameraPosition.back;
  AudioSettings currentAudio = AudioSettings(muted: false, bitrate: 64 * 1000);
  String? currentStatus;

  @override
  void initState() {
    stream = widget.stream;
    initPlatformState();
    connectSocket();
    super.initState();
  }

  void connectSocket() {
    _socket.connect();
    _socket.onConnect(
      (data) {
        _socket.emit('join', '${stream.stream}');
      },
    );
    _socket.onConnect(
      (data) {
        print('Socket Connected');
      },
    );
    _socket.on('count', (data) {
      setState(() {
        stream = Stream.fromJson(data);
      });
    });
    _socket.on('end', (data) {
      print('@@@@@@@@@@ STREAM ENDED @@@@@@@@@@');
    });
  }

  @override
  void dispose() {
    _stream?.dispose();
    _connection?.dispose();
    super.dispose();
  }

  Future<void> startPauseStream() async {
    if (currentStatus != null) {
      if (currentStatus == "live") {
        setState(() {
          currentStatus = 'paused';
          _mode = "playback";
        });
        _stream?.attachVideo(null);
        _stream?.attachAudio(null);
        updateStream({"streamPlayer.play": false, "live": "paused"});
      } else {
        setState(() {
          currentStatus = 'live';
          _mode = "publish";
        });
        _stream?.attachAudio(AudioSource());
        _stream?.attachVideo(VideoSource(
          position: currentPosition,
        ));
        updateStream({"streamPlayer.play": true, "live": "live"});
      }
    } else {
      setState(() {
        currentStatus = 'live';
      });
      _connection?.connect('${widget.stream.url}');
      updateStream({"streamPlayer.play": true});
    }
  }

  Future<void> stopDialouge() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              color: kPrimaryColor,
              padding: const EdgeInsets.all(15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Lottie.asset(
                    "assets/lotties/stop.json",
                    animate: true,
                    repeat: true,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Stoping Stream?',
                    style: kHeadTitleSB.copyWith(color: kWhite),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Are you sure you want to stop the streaming?',
                    style: kSmallTitleR.copyWith(color: kWhite),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: kSolidButton(
                          backgroundColor: kSecondaryColor,
                          // loading: isLoading,
                          onPress: () => Navigator.of(context).pop(),
                          title: 'Continue Stream',
                          titleStyle: kBodyTitleR.copyWith(color: kWhite),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: kSolidButton(
                          backgroundColor: kRedColor,
                          // loading: isLoading,
                          onPress: () => stopStream(),
                          title: 'End Stream',
                          titleStyle: kBodyTitleR.copyWith(color: kWhite),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> stopStream() async {
    Navigator.of(context).pop();
    _connection?.close();
    setState(() {
      _recording = false;
    });
    Navigator.of(context).pop();
  }

  // Fetch all streams
  Future<void> updateStream(Map<String, dynamic> body) async {
    final Response res =
        await _apiProvider.put('/stream/${widget.stream.stream}', body);
    if (res.statusCode == 200) {
      print('Changes Sucess');
    }
  }

  Future<void> muteStreamAudio() async {
    setState(() {
      currentAudio = currentAudio.copyWith(muted: !currentAudio.muted);
    });
    _stream?.audioSettings = currentAudio;
    _stream?.attachAudio(AudioSource());
    updateStream({"streamPlayer.mute": currentAudio.muted ? true : false});
  }

  Future<void> switchCamera() async {
    if (currentPosition == CameraPosition.front) {
      setState(() {
        currentPosition = CameraPosition.back;
      });
    } else {
      setState(() {
        currentPosition = CameraPosition.front;
      });
    }
    _stream?.attachVideo(VideoSource(position: currentPosition));
    updateStream({
      "streamPlayer.camera":
          currentPosition == CameraPosition.back ? "back" : "front"
    });
  }

  Future<void> initPlatformState() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    // Set up AVAudioSession for iOS.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth,
    ));

    RtmpConnection connection = await RtmpConnection.create();
    connection.eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          if (_mode == "publish") {
            _stream?.publish("live");
          } else {
            _stream?.play("live");
          }
          setState(() {
            _recording = true;
          });
          break;
      }
    });

    RtmpStream stream = await RtmpStream.create(connection);
    stream.audioSettings = currentAudio;
    stream.videoSettings = VideoSettings(
      width: 480,
      height: 272,
      bitrate: 512 * 1000,
    );
    stream.attachAudio(AudioSource());
    stream.attachVideo(VideoSource(position: currentPosition));

    if (!mounted) return;

    setState(() {
      _connection = connection;
      _stream = stream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      body: Container(
        child: _stream == null
            ? const Text("")
            : Stack(
                fit: StackFit.expand,
                children: [
                  NetStreamDrawableTexture(_stream),
                  Visibility(
                    visible: _recording,
                    child: Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 50),
                          child: SvgPicture.asset(
                            currentStatus == 'live'
                                ? 'assets/svg/livecircle.svg'
                                : 'assets/svg/pausecircle.svg',
                            height: 30,
                            width: 50,
                          ),
                        )),
                  ),
                  Positioned(
                    top: 60,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/watch.svg",
                            height: 20,
                            width: 50,
                            color: kRedColor,
                          ),
                          Text(
                            ' ${stream.count}',
                            style: kBodyTitleSB,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: kWhite,
                          size: 30,
                        ),
                        onPressed: () => stopDialouge(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kPrimaryColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          kIconButton(
                            icon: currentPosition == CameraPosition.front
                                ? 'assets/svg/interface/camera.svg'
                                : 'assets/svg/interface/front.svg',
                            color: kWhite,
                            onPressed: () => switchCamera(),
                          ),
                          kIconButton(
                            icon: currentStatus == 'live'
                                ? 'assets/svg/interface/pause.svg'
                                : 'assets/svg/interface/play.svg',
                            color: kWhite,
                            onPressed: () => startPauseStream(),
                          ),
                          kIconButton(
                            icon: currentAudio.muted
                                ? 'assets/svg/interface/micmute.svg'
                                : 'assets/svg/interface/mic.svg',
                            color: currentAudio.muted ? kRedColor : kWhite,
                            backgroundColor: currentAudio.muted
                                ? kWhite
                                : kPrimaryLightColor,
                            onPressed: () => muteStreamAudio(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
