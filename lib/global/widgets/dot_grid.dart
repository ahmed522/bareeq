import 'package:bareeq/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

import '2D_grid_view.dart';
import 'dots_painter.dart';

class DotGrid extends StatelessWidget {
  const DotGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      TwoDimensionalGridView(
        diagonalDragBehavior: DiagonalDragBehavior.free,
        delegate: TwoDimensionalChildBuilderDelegate(
            maxXIndex: 1000,
            maxYIndex: 1000,
            builder: (BuildContext context, ChildVicinity vicinity) {
              return CustomPaint(
                size: Size( size.width, size.height),
                painter: DotsPainter(setPadding: vicinity.xIndex%2==0,dotsColor: CommonFunctions.isLightMode(context)?Colors.black:Colors.white),
              );
            }),
        elementWidth: size.width,
        elementHeight: size.height-50,
        verticalDetails: ScrollableDetails.vertical(controller: ScrollController(initialScrollOffset: size.height*500)),
        horizontalDetails: ScrollableDetails.horizontal(controller: ScrollController(initialScrollOffset: size.width*500)),
      );
  }
}

