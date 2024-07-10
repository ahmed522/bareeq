import 'package:flutter/material.dart';

class CommonFunctions {
  static bool isLightMode(BuildContext context) =>
      (Theme.of(context).brightness == Brightness.light);
}
