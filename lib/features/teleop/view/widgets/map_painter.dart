import 'package:flutter/material.dart';
import 'package:flutter_rviz/struct/occupancy_grid.dart';

class OccupancyGridPainter extends CustomPainter {
  final OccupancyGrid grid;
  OccupancyGridPainter(
    this.grid,
    this.freeSpaceColor,
    this.occupiedSpaceColor,
    this.unknownSpaceColor,
    this.updateMapCanvasSize,
  );

  final Color freeSpaceColor;
  final Color occupiedSpaceColor;
  final Color unknownSpaceColor;
  final Function(double width, double height) updateMapCanvasSize;
  @override
  void paint(Canvas canvas, Size size) {
    updateMapCanvasSize(size.width, size.height);
    final paint = Paint();
    final double cellWidth = size.width / grid.mapMetaData.width;
    final double cellHeight = size.height / grid.mapMetaData.height;
    List<int> data = grid.data;
    canvas.translate(0.0, size.height);
    canvas.scale(1.0, -1.0);

    for (int y = 0; y < grid.mapMetaData.height; y++) {
      for (int x = 0; x < grid.mapMetaData.width; x++) {
        int value = data[y * grid.mapMetaData.width + x];
        Color color;
        if (value == 0) {
          color = freeSpaceColor; // Free space
        } else if (value == 100) {
          color = occupiedSpaceColor; // Occupied space
        } else {
          color = unknownSpaceColor; // Unknown space
        }

        paint.color = color;

        canvas.drawRect(
          Rect.fromLTWH(x * cellWidth, y * cellHeight, cellWidth, cellHeight),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
