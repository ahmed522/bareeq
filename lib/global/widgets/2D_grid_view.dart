


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '2D_grid_view_port.dart';

class TwoDimensionalGridView extends TwoDimensionalScrollView {
  const TwoDimensionalGridView({
    required this.elementHeight,
    required this.elementWidth,
    super.key,
    super.primary,
    super.mainAxis = Axis.vertical,
    super.verticalDetails =  const ScrollableDetails.vertical(),
    super.horizontalDetails = const ScrollableDetails.horizontal(),
    required TwoDimensionalChildBuilderDelegate delegate,
    super.cacheExtent,
    super.diagonalDragBehavior = DiagonalDragBehavior.free,
    super.dragStartBehavior = DragStartBehavior.start,
    super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);
  final double elementHeight;
  final double elementWidth;
  @override
  Widget buildViewport(
      BuildContext context,
      ViewportOffset verticalOffset,
      ViewportOffset horizontalOffset,
      ) {
    return TwoDimensionalGridViewport(
      elementHeight: elementHeight,
      elementWidth: elementWidth,
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }
}

