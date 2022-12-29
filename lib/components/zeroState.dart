import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

Widget zerostate(
    {icon,
    head,
    sub,
    double size = 150,
    double height = 560,
    String type = "svg"}) {
  return Container(
    height: height,
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (type == "svg")
          SvgPicture.asset(
            icon,
            height: size,
          ),
        if (type == "lottie")
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
              icon,
              animate: true,
              repeat: true,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        Text(
          head,
          style: kHeadTitleSB.copyWith(color: kWhite),
        ),
        SizedBox(
          width: 300,
          child: Text(
            sub,
            textAlign: TextAlign.center,
            style: kSmallTitleR.copyWith(color: kWhite),
          ),
        ),
      ],
    )),
  );
}
