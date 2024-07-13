import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ControlJoystick extends StatelessWidget {
  const ControlJoystick({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = ControlCubit.get(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircleButton(
                backgroundColor: Colors.red,
                shadowColor: Colors.red.shade300,
                onPressed: () {
                  cubit.moveBack();
                },
                child: const Icon(
                  FontAwesomeIcons.arrowDownLong,
                  color: Colors.white,
                  size: 15,
                )),
          ),
        ),
        Joystick(
          listener: (details) {
            cubit.sendJoystickData(details.x, -details.y);
          },
          includeInitialAnimation: false,
          stick: JoystickStick(
            decoration: JoystickStickDecoration(
              color: Colors.green,
              shadowColor:
                  const Color.fromRGBO(76, 175, 80, 1).withOpacity(0.2),
            ),
          ),
          base: JoystickBase(
            size: (size.width / 2) - 20,
            decoration: JoystickBaseDecoration(
              middleCircleColor: AppColors.primaryColor,
              innerCircleColor: AppColors.secondryColor.withOpacity(0.3),
              drawOuterCircle: false,
              boxShadowColor: AppColors.primaryColor.withOpacity(0.2),
              drawArrows: false,
            ),
          ),
        ),
      ],
    );
  }
}
