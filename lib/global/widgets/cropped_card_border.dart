import 'package:flutter/material.dart';

class CroppedCardBorder extends ShapeBorder {
  const CroppedCardBorder({
    required this.borderRadius,
    required this.holeSize1,
    required this.holeSize2,
    this.offset1 = Offset.zero,
    this.offset2 = Offset.zero,
    this.side = BorderSide.none,
  });

  final Radius borderRadius;
  final Offset offset1;
  final Offset offset2;
  final BorderSide side;
  final double holeSize1;
  final double holeSize2;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _getPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side != BorderSide.none) {
      canvas.drawPath(
        _getPath(rect),
        side.toPaint(),
      );
    }
  }

  Path _getPath(Rect rect) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRRect(RRect.fromRectAndRadius(rect, borderRadius)),
      Path()
        ..addOval(Rect.fromCircle(
          center: Offset(0, rect.height) + offset1,
          radius: holeSize1,
        ))
        ..addOval(Rect.fromCircle(
          center: Offset(0, rect.height) + offset2,
          radius: holeSize2,
        )),
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}
