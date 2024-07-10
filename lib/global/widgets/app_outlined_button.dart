import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.text,
    this.fontSize = 20.0,
    this.icon,
    this.iconSize = 25.0,
    required this.onPressed,
  });
  final String? text;
  final double fontSize;
  final IconData? icon;
  final double iconSize;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: CommonFunctions.isLightMode(context)
            ? AppColors.primaryColor
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 2.0,
            color: CommonFunctions.isLightMode(context)
                ? AppColors.primaryColor
                : Colors.white,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                fontSize: fontSize,
                color: CommonFunctions.isLightMode(context)
                    ? AppColors.primaryColor
                    : Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (icon != null && text != null) const SizedBox(width: 15),
          if (icon != null)
            Icon(
              icon,
              color: CommonFunctions.isLightMode(context)
                  ? AppColors.primaryColor
                  : Colors.white,
              size: iconSize,
            ),
        ],
      ),
    );
  }
}
