import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppTextTheme {
  static TextStyle _getBodyText1Style(Brightness brightness) => TextStyle(
        color: brightness == Brightness.light
            ? AppColors.primaryColor
            : Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      );
  static TextStyle _getBodyText2Style(Brightness brightness) => TextStyle(
        color: brightness == Brightness.light
            ? AppColors.primaryColor
            : Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 25,
      );

  static TextTheme getAppTextTheme(Brightness brightness) => TextTheme(
        bodyLarge: _getBodyText1Style(brightness),
        bodyMedium: _getBodyText2Style(brightness),
      );
  static const TextStyle appBarTitleTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
}
