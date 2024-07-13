import 'package:bareeq/global/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppbarTheme {
  static AppBarTheme getAppBarTheme(Brightness brightness) => AppBarTheme(
        toolbarHeight: 0,
        titleTextStyle: AppTextTheme.appBarTitleTextStyle,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor:
            (brightness == Brightness.light) ? Colors.white : Colors.black,
      );
}
