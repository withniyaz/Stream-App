import 'package:flutter/material.dart';
import 'package:stream_app/constants/color_constants.dart';

//Hike Application Solid Button Components: Made to use multiple times through out the project

Widget kSolidButton(
    {VoidCallback? onPress,
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    bool loading = false,
    double? radius = 5,
    double? height = 45,
    double? width = double.infinity}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: onPress == null ? kGreyLight : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
      onPressed: loading ? null : onPress,
      child: loading
          ? const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ))
          : Text(
              '$title',
              style: titleStyle,
            ),
    ),
  );
}

Widget kSolidButtonLeading(
    {VoidCallback? onPress,
    String? title,
    EdgeInsetsGeometry? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? titleStyle,
    Color? backgroundColor,
    bool loading = false,
    double? radius = 5,
    double? height = 45}) {
  return SizedBox(
    height: height,
    child: TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: onPress == null ? kGreyLight : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
      onPressed: loading ? null : onPress,
      child: loading
          ? const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Text(
                      '$title',
                      style: titleStyle,
                    ),
                Text(
                  '$title',
                  style: titleStyle,
                ),
              ],
            ),
    ),
  );
}
