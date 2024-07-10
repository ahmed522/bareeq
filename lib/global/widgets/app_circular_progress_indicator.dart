import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: CommonFunctions.isLightMode(context)
            ? AppColors.primaryColor
            : AppColors.lightColor1,
      ),
    );
  }
}
