import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppSnackBar {
  static void showSnackBar(BuildContext context, String msg, [Color? color]) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        backgroundColor: color ?? AppColors.primaryColor,
      ),
    );
  }
}
