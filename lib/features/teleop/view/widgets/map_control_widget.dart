import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/model/map_mode.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MapControlWidget extends StatelessWidget {
  const MapControlWidget({super.key, required this.mode});
  final MapMode mode;
  @override
  Widget build(BuildContext context) {
    final cubit = ControlCubit.get(context);
    return Column(
      children: [
        const ContaineredText(
          text: 'Map\nMode',
          color: Colors.deepOrange,
          fontSize: 10,
        ),
        const SizedBox(height: 3),
        ToggleSwitch(
          initialLabelIndex: mode.index,
          totalSwitches: 3,
          isVertical: true,
          onToggle: (index) {
            cubit.updateMapMode(index!);
          },
          minWidth: 40,
          customIcons: const [
            Icon(
              Icons.update_rounded,
              color: Colors.white,
              size: 20,
            ),
            Icon(
              Icons.hide_source_rounded,
              color: Colors.white,
              size: 20,
            ),
            Icon(
              Icons.update_disabled_outlined,
              color: Colors.white,
              size: 20,
            ),
          ],
          activeBgColors: const [
            [
              Colors.greenAccent,
              Colors.green,
              Colors.lime,
            ],
            [
              Colors.red,
            ],
            [
              Colors.greenAccent,
              Colors.green,
              Colors.lime,
            ],
          ],
        ),
      ],
    );
  }
}
