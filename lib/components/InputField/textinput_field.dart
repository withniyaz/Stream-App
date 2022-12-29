import 'package:flutter/material.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

//Hike Application Text Input Components: Made to use multiple times through out the project

Widget kTextInputField(
    {required TextEditingController controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    TextInputType? keyboard,
    bool enabled = true,
    EdgeInsetsGeometry? contentPadding,
    void Function()? onTap,
    String? suffixText,
    Widget? suffix,
    String? title,
    TextStyle? titleStyle,
    int? maxLines = 1,
    bool mobile = false,
    bool password = false,
    double padding = 8}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: padding,
    ),
    child: TextFormField(
      style: const TextStyle(color: kWhite),
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboard ?? TextInputType.text,
      controller: controller,
      obscureText: password,
      validator: validator,
      onChanged: onChanged,
      // style: titleStyle ?? kBodyTitleM,
      decoration: InputDecoration(
        suffix: suffix,
        suffixText: suffixText,
        contentPadding: contentPadding ?? const EdgeInsets.all(10),
        focusColor: kPrimaryLightColor,
        labelStyle: kBodyTitleR.copyWith(color: kWhite),
        floatingLabelStyle: kBodyTitleR.copyWith(color: kWhite),
        labelText: title,
        prefixText: mobile ? "+91 | " : null,
        prefixStyle: kBodyTitleM,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: kPrimaryDarkColor,
          ),
        ),
      ),
    ),
  );
}
