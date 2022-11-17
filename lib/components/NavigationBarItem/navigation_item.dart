import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_app/constants/color_constants.dart';

BottomNavigationBarItem kNavigationItem({
  required String icon,
  required String? title,
}) {
  return BottomNavigationBarItem(
    activeIcon: SvgPicture.asset(
      icon,
      color: kWhite,
      height: 24,
    ),
    icon: SvgPicture.asset(
      icon,
      color: kGreyLight,
      height: 24,
    ),
    label: title,
  );
}
