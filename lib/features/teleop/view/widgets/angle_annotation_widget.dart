import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:flutter/material.dart';

class AngleAnnotationWidget extends StatelessWidget {
  const AngleAnnotationWidget(
      {super.key,
      required this.title,
      required this.angle,
      required this.fontSize});
  final String title;
  final double angle;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContaineredText(
          text: title,
          color: Colors.deepOrange,
          fontSize: 10,
        ),
        Text(
          '${angle.ceil()}°',
          style: TextStyle(
            fontSize: fontSize,
            color: CommonFunctions.isLightMode(context)
                ? Colors.black
                : Colors.white,
            shadows: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0.4,
                blurRadius: 1,
                offset: Offset(0, 0.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
