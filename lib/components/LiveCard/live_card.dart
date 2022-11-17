import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

Widget liveCard() {
  return Container(
    height: 200,
    width: 100,
    margin: const EdgeInsets.only(bottom: 10),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      image: const DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          'assets/images/temp/streamer_2.jpg',
        ),
      ),
      color: kWhite,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(.3),
              kSecondaryColor.withOpacity(.7),
            ]),
      ),
      child: Stack(
        children: [
          SvgPicture.asset('assets/svg/livecircle.svg'),
          Center(
            child: SvgPicture.asset('assets/svg/play.svg'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/temp/stream_ui.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Python Training',
                          style: kBodyTitleSB.copyWith(color: kWhite),
                        ),
                        Text(
                          'Techies Dev Group',
                          style: kSmallTitleR.copyWith(color: kWhite),
                        )
                      ],
                    )
                  ],
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
            ),
          )
        ],
      ),
    ),
  );
}
