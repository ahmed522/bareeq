import 'package:flutter/material.dart';

class ContaineredText extends StatelessWidget {
  const ContaineredText({
    super.key,
    required this.text,
    required this.color,
    this.borderRadius = 5,
    required this.fontSize,
  });

  final String text;
  final Color color;
  final double borderRadius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0.3,
            blurRadius: 1,
            offset: Offset(0, 0.3),
          ),
        ],
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
