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
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_app/components/Buttons/iconsvg_button.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';

class StreamScreen extends StatefulWidget {
  final Stream stream;
  const StreamScreen({Key? key, required this.stream}) : super(key: key);

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  RtmpConnection? _connection;
  RtmpStream? _stream;
  bool _recording = false;
  String _mode = "publish";
  CameraPosition currentPosition = CameraPosition.back;
  AudioSettings currentAudio = AudioSettings(muted: false, bitrate: 64 * 1000);
  String? currentStatus;

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
      } else {
        setState(() {
          currentStatus = 'live';
          _mode = "publish";
        });
        _stream?.attachAudio(AudioSource());
        _stream?.attachVideo(VideoSource(
          position: currentPosition,
        ));
      }
    } else {
      setState(() {
        currentStatus = 'live';
      });
      _connection?.connect('${widget.stream.url}');
    }
  }

  Future<void> stopStream() async {
    _connection?.close();
    setState(() {
      _recording = false;
    });
    Navigator.of(context).pop();
  }

  Future<void> muteStreamAudio() async {
    setState(() {
      currentAudio = currentAudio.copyWith(muted: !currentAudio.muted);
    });
    _stream?.audioSettings = currentAudio;
    _stream?.attachAudio(AudioSource());
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
                        onPressed: () => stopStream(),
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
                            onPressed: () {
                              if (currentPosition == CameraPosition.front) {
                                setState(() {
                                  currentPosition = CameraPosition.back;
                                });
                              } else {
                                setState(() {
                                  currentPosition = CameraPosition.front;
                                });
                              }
                              _stream?.attachVideo(
                                  VideoSource(position: currentPosition));
                            },
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
