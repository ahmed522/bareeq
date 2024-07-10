import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/controller/control_states.dart';
import 'package:bareeq/features/teleop/model/map_mode.dart';
import 'package:bareeq/features/teleop/model/velocity_type.dart';
import 'package:bareeq/features/teleop/view/widgets/brush_control_widget.dart';
import 'package:bareeq/features/teleop/view/widgets/joystick.dart';
import 'package:bareeq/features/teleop/view/widgets/map_control_widget.dart';
import 'package:bareeq/features/teleop/view/widgets/map_widget.dart';
import 'package:bareeq/features/teleop/view/widgets/orientation_gauge.dart';
import 'package:bareeq/features/teleop/view/widgets/radial_range_slider.dart';
import 'package:bareeq/features/teleop/view/widgets/velocity_display.dart';
import 'package:bareeq/global/constants/numbers.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:bareeq/global/widgets/dot_grid.dart';
import 'package:bareeq/global/widgets/error_page.dart';
import 'package:bareeq/global/widgets/loading_page.dart';
import 'package:bareeq/global/widgets/notify_widget.dart';
import 'package:bareeq/global/widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({
    super.key,
  });
  static const String route = '/controlScreen';
  @override
  Widget build(BuildContext context) {
    final cubit = ControlCubit.get(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const DotGrid(),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: Icon(
                            Icons.arrow_circle_left_rounded,
                            color: CommonFunctions.isLightMode(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                          iconSize: 30,
                        ),
                        ScreenTitle(
                          bottomPadding: 0,
                          leftPadding: 0,
                          topPadding: 0,
                          title: 'Control',
                          titleColor: (!CommonFunctions.isLightMode(context))
                              ? Colors.white
                              : Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        NotifyWidget(
                          size: 15,
                          color: Colors.green,
                          shadowColor: Colors.green.shade400,
                        ),
                        const SizedBox(width: 3),
                        ContaineredText(
                          text: 'Connected',
                          color: Colors.green,
                          fontSize: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<ControlCubit, ControlStates>(
              builder: (context, state) {
                if (state is ControlLoadingState) {
                  return const LoadingPage();
                } else if (state is ControlErrorState) {
                  return const ErrorPage();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (cubit.mapMode != MapMode.hide &&
                            cubit.map != null &&
                            cubit.odom != null)
                          MapWidget(
                            grid: cubit.map!,
                            odom: cubit.odom!,
                            occupiedSpaceColor:
                                (CommonFunctions.isLightMode(context))
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: OrientationGauge(
                                  angle: cubit.robotOrientation,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: MapControlWidget(mode: cubit.mapMode),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RadialRangeSlider(
                                        title: 'Base',
                                        startValue:
                                            AppNumbers.baseJointStartAngle,
                                        endValue: AppNumbers.baseJointEndAngle,
                                        value: cubit.baseJointAngle,
                                        actualValue: cubit.baseJointActualAngle,
                                      ),
                                      RadialRangeSlider(
                                        title: 'Elbow',
                                        startValue:
                                            AppNumbers.elbowJointStartAngle,
                                        endValue: AppNumbers.elbowJointEndAngle,
                                        value: cubit.elbowJointAngle,
                                        actualValue:
                                            cubit.elbowJointActualAngle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          bottom: 10.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BrushControlWidget(
                                              mode: cubit.brushMode,
                                            ),
                                            const SizedBox(height: 5),
                                            VelocityDisplay(
                                              velocity: cubit.linearVelocity,
                                              velocityType:
                                                  VelocityType.linearVelocity,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: ControlJoystick(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
