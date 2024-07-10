import 'package:flutter/material.dart';

class DotsPainter extends CustomPainter {
  DotsPainter({required this.setPadding, required this.dotsColor,this.dotSize = 1.0,this.dotSpacing = 22.0});
  final Color dotsColor;
  final double dotSize;
  final double dotSpacing;
  final bool setPadding;
  @override
  void paint(Canvas canvas, Size size) {


    final paint = Paint()
      ..color = dotsColor
      ..style = PaintingStyle.fill;

    for (double x =setPadding?0: size.width%dotSpacing; x < size.width; x += dotSpacing) {
      for (double y =0; y < size.height; y += dotSpacing) {

        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}