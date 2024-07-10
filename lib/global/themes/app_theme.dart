
import 'package:bareeq/global/themes/a_app_bar_theme.dart';
import 'package:bareeq/global/themes/app_buttons_theme.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData _getThemeData(Brightness brightness) => ThemeData(
        scaffoldBackgroundColor: (brightness == Brightness.light)?Colors.white:Colors.black,
        textTheme: AppTextTheme.getAppTextTheme(brightness),
        appBarTheme: AppbarTheme.getAppBarTheme(brightness),
        elevatedButtonTheme:
            AppButtonsTheme.getAppElevatedButtonTheme(brightness),
        textButtonTheme: AppButtonsTheme.getAppTextButtonTheme(brightness),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColors.primaryColor,
              secondary: AppColors.secondryColor,
              brightness: brightness,
            ),
      );
  static ThemeData get appLightTheme => _getThemeData(Brightness.light);
  static ThemeData get appDarkTheme => _getThemeData(Brightness.dark);
}
