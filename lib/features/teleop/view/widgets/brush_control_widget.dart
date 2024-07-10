import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/model/brush_operating_mode.dart';
import 'package:bareeq/global/constants/numbers.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BrushControlWidget extends StatelessWidget {
  const BrushControlWidget({
    super.key,
    required this.mode,
  });
  final BrushOperatingMode mode;

  @override
  Widget build(BuildContext context) {
    final cubit = ControlCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ContaineredText(
          text: 'Brush',
          color: Colors.deepOrange,
          fontSize: 15,
        ),
        const SizedBox(height: 3),
        ToggleSwitch(
          initialLabelIndex: mode.index,
          totalSwitches: 3,
          cancelToggle: (index) async {
            if (cubit.brushMotorInRest) {
              return true;
            }
            if (mode == BrushOperatingMode.off || index == 1) {
              cubit.updateBrushMode(BrushOperatingMode.values[index!]);
              return false;
            }
            cubit.updateBrushMode(BrushOperatingMode.off);
            cubit.updateBrushMotorInRest(true);
            Future.delayed(const Duration(
                    seconds: AppNumbers.brushMotorRestTimeInSeconds))
                .then((_) {
              cubit.updateBrushMode(BrushOperatingMode.values[index!]);
              cubit.updateBrushMotorInRest(false);
            });
            return false;
          },
          customWidths: const [
            35,
            35,
            35,
          ],
          customIcons: const [
            Icon(
              FontAwesomeIcons.rotateLeft,
              color: Colors.white,
              size: 15,
            ),
            Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
              size: 15,
            ),
            Icon(
              FontAwesomeIcons.rotateRight,
              color: Colors.white,
              size: 15,
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
