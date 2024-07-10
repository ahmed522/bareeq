import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class CardTextField extends StatelessWidget {
  const CardTextField({
    super.key,
    this.controller,
    this.onChanged,
    required this.keyboardType,
    this.hintText,
    this.shadowColor,
    this.elevation = 3,
    this.color,
    this.icon,
    this.hintStyle,
    this.iconColor,
    this.textDirection,
    this.maxLength,
  });
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? hintText;
  final TextInputType keyboardType;
  final Color? shadowColor;
  final Color? color;
  final Color? iconColor;
  final double elevation;
  final IconData? icon;
  final TextStyle? hintStyle;
  final TextDirection? textDirection;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (color != null)
          ? color
          : CommonFunctions.isLightMode(context)
              ? Colors.white
              : AppColors.darkThemeBottomNavBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: elevation,
      shadowColor: shadowColor,
      child: TextField(
        controller: controller,
        textDirection: textDirection,
        decoration: InputDecoration(
          counterText: '',
          icon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                )
              : null,
          hintText: hintText,
          hintStyle: hintStyle,
          filled: true,
          fillColor: (color != null)
              ? color
              : CommonFunctions.isLightMode(context)
                  ? Colors.white
                  : AppColors.darkThemeBottomNavBarColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.all(15.0),
        ),
        cursorHeight: 20,
        onChanged: onChanged != null ? (value) => onChanged!(value) : null,
        enabled: true,
        keyboardType: keyboardType,
        obscureText: (keyboardType == TextInputType.visiblePassword),
        maxLength: maxLength,
      ),
    );
  }
}
