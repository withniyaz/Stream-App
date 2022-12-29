import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';

class StreamPlayScreen extends StatefulWidget {
  final Stream stream;
  const StreamPlayScreen({Key? key, required this.stream}) : super(key: key);
  @override
  State<StreamPlayScreen> createState() => _StreamPlayScreenState();
}

class _StreamPlayScreenState extends State<StreamPlayScreen> {
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
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _vlcViewController?.stopRendererScanning();
    await _vlcViewController?.dispose();
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
                child: SvgPicture.asset(
                  'assets/svg/livecircle.svg',
                  height: 20,
                  width: 50,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edward Younds .',
                      style: kSmallTitleR.copyWith(color: kWhite),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/watch.svg'),
                        Text(
                          '20 Watching',
                          style: kSmallTitleR.copyWith(color: kWhite),
                        )
                      ],
                    )
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
