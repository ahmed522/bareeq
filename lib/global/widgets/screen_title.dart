import 'package:bareeq/global/constants/app_assets.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final double topPadding;
  final double leftPadding;
  final double bottomPadding;
  final double rightPadding;
  final String title;
  final double fontSize;
  final Color? titleColor;
  const ScreenTitle({
    super.key,
    required this.title,
    this.fontSize = 30.0,
    this.titleColor,
    this.topPadding = 45.0,
    this.leftPadding = 25.0,
    this.bottomPadding = 15.0,
    this.rightPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          left: leftPadding,
          bottom: bottomPadding,
          right: rightPadding,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1.8 * size.width / 3),
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: titleColor,
              fontFamily: AppAssets.mainEnglishFont,
            ),
          ),
        ),
      ),
    );
  }
}
