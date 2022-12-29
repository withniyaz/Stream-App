import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_app/constants/color_constants.dart';

//Hike Application Icon Svg Button Components: Made to use multiple times through out the project

Widget kIconButton(
    {void Function()? onPressed,
    required String icon,
    Color? color,
    Color? backgroundColor = kPrimaryLightColor,
    double? iconSize}) {
  return CircleAvatar(
    backgroundColor: backgroundColor,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: IconButton(
        padding: const EdgeInsets.all(5),
        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
        splashRadius: 15,
        onPressed: onPressed,
        icon: SvgPicture.asset(
          icon,
          color: color,
          width: iconSize,
        ),
      ),
    ),
  );
}
