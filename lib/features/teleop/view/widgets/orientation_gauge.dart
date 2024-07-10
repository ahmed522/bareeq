import 'package:bareeq/global/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OrientationGauge extends StatelessWidget {
  const OrientationGauge({super.key, required this.angle});
  final double? angle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkThemeBottomNavBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 0.8,
            blurRadius: 2,
            offset: Offset(0, 0.8),
          ),
        ],
      ),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            labelOffset: 0,
            tickOffset: 1,
            majorTickStyle: const MajorTickStyle(thickness: 1, length: 8),
            minorTickStyle: const MinorTickStyle(thickness: 0.7, length: 3),
            showLabels: false,
            showAxisLine: false,
            startAngle: 0,
            endAngle: 0,
            minimum: 0,
            maximum: 360,
            interval: 10,
            pointers: <GaugePointer>[
              MarkerPointer(
                markerType: MarkerType.triangle,
                markerWidth: 4,
                markerHeight: 10,
                markerOffset: 12,
                value: (angle == null)
                    ? 0
                    : (angle! >= 0)
                        ? (360 - angle!)
                        : -angle!,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
