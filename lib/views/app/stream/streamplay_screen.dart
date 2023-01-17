import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_app/constants/app_constants.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class StreamPlayScreen extends StatefulWidget {
  final Stream stream;
  const StreamPlayScreen({Key? key, required this.stream}) : super(key: key);
  @override
  State<StreamPlayScreen> createState() => _StreamPlayScreenState();
}

class _StreamPlayScreenState extends State<StreamPlayScreen> {
  final io.Socket _socket = io.io(socketFullUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  late Stream stream;
  VlcPlayerController? _vlcViewController;
  @override
  void initState() {
    stream = widget.stream;
    _vlcViewController = VlcPlayerController.network(
      "${widget.stream.url}/live",
      autoPlay: true,
      options: VlcPlayerOptions(video: VlcVideoOptions([])),
    );
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
    _socket.on('control', (data) {
      setState(() {
        stream = Stream.fromJson(data);
      });
    });
    _socket.on('end', (data) {
      print('@@@@@@@@@@ STREAM ENDED @@@@@@@@@@');
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _vlcViewController?.stopRendererScanning();
    await _vlcViewController?.dispose();
    _socket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              VlcPlayer(
                controller: _vlcViewController!,
                aspectRatio: 16 / 9,
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        stream.live == "live"
                            ? 'assets/svg/livecircle.svg'
                            : "assets/svg/pausecircle.svg",
                        height: 20,
                        width: 50,
                      ),
                      Visibility(
                        visible: stream.streamPlayer?.mute == true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SvgPicture.asset(
                            'assets/svg/interface/micmute.svg',
                            height: 17,
                            width: 17,
                            color: kRedColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: SvgPicture.asset(
                  'assets/svg/fullscreen.svg',
                  height: 20,
                  width: 50,
                ),
              ),
              Positioned(
                top: 50,
                left: 15,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset(
                    'assets/svg/arrowdown.svg',
                    height: 20,
                    width: 50,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: kPrimaryDarkColor,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stream.name}',
                  style: kHeadTitleM.copyWith(color: kWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            '${stream.user?.profile?.profileImage}')),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  ${stream.user?.profile?.name}',
                                style: kSmallTitleR.copyWith(color: kWhite),
                              ),
                              Text(
                                '  ${stream.user?.profile?.email}',
                                style: kSmallTitleR.copyWith(color: kWhite),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/watch.svg'),
                              Text(
                                '${stream.count} Watching',
                                style: kSmallTitleR.copyWith(color: kWhite),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
