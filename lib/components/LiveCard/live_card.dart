import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';

Widget liveCard(Stream e, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, 'Stream', arguments: e),
    child: Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider('${e.thumbnail?.file}'),
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
                kRedColor.withOpacity(.7),
              ]),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(e.live == "live"
                ? 'assets/svg/livecircle.svg'
                : 'assets/svg/pausecircle.svg'),
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
                      CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              '${e.user?.profile?.profileImage}')),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${e.name}',
                            style: kBodyTitleSB.copyWith(color: kWhite),
                          ),
                          Text(
                            '${e.user?.profile?.name}',
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
                        ' ${e.count} Watching',
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
    ),
  );
}
