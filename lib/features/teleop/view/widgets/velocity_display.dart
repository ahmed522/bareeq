import 'package:bareeq/features/teleop/model/velocity_type.dart';
import 'package:bareeq/global/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

class VelocityDisplay extends StatelessWidget {
  const VelocityDisplay(
      {super.key, required this.velocity, required this.velocityType});
  final double velocity;
  final VelocityType velocityType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: const BoxDecoration(
            color: AppColors.darkThemeBottomNavBarColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(2),
            ),
          ),
          child: Text(
            (velocityType == VelocityType.linearVelocity)
                ? 'Linear'
                : 'Angular',
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: SevenSegmentDisplay(
                value: velocity.toStringAsFixed(
                    (velocityType == VelocityType.linearVelocity) ? 2 : 1),
                size: 3,
                segmentStyle: DefaultSegmentStyle(
                  enabledColor: Colors.green,
                  disabledColor: Colors.green.withOpacity(0.25),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: const BoxDecoration(
                color: AppColors.darkThemeBottomNavBarColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(2),
                ),
              ),
              child: Text(
                (velocityType == VelocityType.linearVelocity) ? 'm/s' : 'rpm',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
