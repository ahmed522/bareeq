import 'dart:math';

import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/view/widgets/map_painter.dart';
import 'package:bareeq/global/constants/app_assets.dart';
import 'package:bareeq/global/constants/numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rviz/flutter_rviz.dart';

import 'package:lottie/lottie.dart';

class MapWidget extends StatelessWidget {
  final OccupancyGrid grid;
  const MapWidget({
    super.key,
    required this.grid,
    required this.odom,
    this.freeSpaceColor = Colors.greenAccent,
    this.occupiedSpaceColor = Colors.black,
    this.unknownSpaceColor = Colors.transparent,
  });
  final Color freeSpaceColor;
  final Color occupiedSpaceColor;
  final Color unknownSpaceColor;
  final Pose odom;
  @override
  Widget build(BuildContext context) {
    final cubit = ControlCubit.get(context);
    final Size mapCanvasSize = (cubit.mapCanvasSize == null)
        ? const Size(
            AppNumbers.mapCanvasDefualtWidth, AppNumbers.mapCanvasDefualtHeight)
        : cubit.mapCanvasSize!;
    double yScaleFactor = mapCanvasSize.height /
        (grid.mapMetaData.resolution * grid.mapMetaData.height);
    double xScaleFactor = mapCanvasSize.width /
        (grid.mapMetaData.resolution * grid.mapMetaData.width);
    double xOrigin = mapCanvasSize.width / 2;
    double yOrigin = mapCanvasSize.height / 2;
    double x = xScaleFactor * odom.position.x;
    double y = -yScaleFactor * odom.position.y;
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 1,
      maxScale: 5.0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(
              grid.mapMetaData.width.toDouble(),
              grid.mapMetaData.height.toDouble(),
            ),
            painter: OccupancyGridPainter(
              grid,
              freeSpaceColor,
              occupiedSpaceColor,
              unknownSpaceColor,
              (width, height) => cubit.updateMapCanvasSize(width, height),
            ),
          ),
          Positioned(
            left: xOrigin + x - AppNumbers.robotWidth * yScaleFactor / 4,
            top: yOrigin + y - AppNumbers.robotWidth * yScaleFactor * 5,
            child: Lottie.asset(
              AppAssets.pulsatingDotAnimationAsset,
              width: AppNumbers.robotWidth * xScaleFactor * 5,
              height: AppNumbers.robotWidth * yScaleFactor * 5,
            ),
          )
        ],
      ),
    );
  }
}
