import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/view/widgets/angle_annotation_widget.dart';
import 'package:bareeq/global/constants/app_assets.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialRangeSlider extends StatelessWidget {
  const RadialRangeSlider(
      {super.key,
      required this.title,
      required this.startValue,
      required this.endValue,
      required this.value,
      required this.actualValue});
  final String title;
  final double startValue;
  final double endValue;
  final double value;
  final double actualValue;
  @override
  Widget build(BuildContext context) {
    final cubit = ControlCubit.get(context);
    final size = MediaQuery.of(context).size;
    double gaugeSize = size.width / 2;
    double annotationFontSize = 25;
    if (gaugeSize < 130) {
      annotationFontSize = 15;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: gaugeSize,
          width: gaugeSize,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 4000,
            axes: <RadialAxis>[
              RadialAxis(
                startAngle: 120,
                endAngle: 60,
                radiusFactor: 1,
                minimum: startValue,
                maximum: endValue,
                showTicks: false,
                canRotateLabels: true,
                showLastLabel: true,
                showAxisLine: false,
                labelOffset: 10,
                labelsPosition: ElementsPosition.outside,
                axisLabelStyle: GaugeTextStyle(
                  fontSize: 10,
                  fontFamily: AppAssets.mainEnglishFont,
                  color: CommonFunctions.isLightMode(context)
                      ? Colors.black
                      : Colors.white,
                ),
                interval: 10,
                useRangeColorForAxis: true,
                ranges: [
                  GaugeRange(
                    startValue: startValue,
                    endValue: value + 1,
                    startWidth: 15,
                    endWidth: 15,
                    color: Colors.deepOrangeAccent,
                    gradient: const SweepGradient(
                      colors: <Color>[
                        Colors.deepOrange,
                        Colors.deepOrangeAccent,
                        Colors.orange,
                      ],
                      stops: <double>[
                        0.25,
                        0.50,
                        0.75,
                      ],
                    ),
                  )
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                    enableDragging: true,
                    overlayColor: Colors.orange,
                    overlayRadius: 20,
                    markerType: MarkerType.circle,
                    markerWidth: 12,
                    markerHeight: 12,
                    markerOffset: 2.5,
                    value: value,
                    color: Colors.white,
                    borderColor: Colors.orange,
                    borderWidth: 3,
                    onValueChanged: (title == 'Base')
                        ? (newValue) => cubit.updateBaseJointAngle(newValue)
                        : (newValue) => cubit.updateElbowJointAngle(newValue),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    positionFactor: 0.1,
                    angle: 30,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AngleAnnotationWidget(
                          title: 'set',
                          angle: value,
                          fontSize: annotationFontSize,
                        ),
                        AngleAnnotationWidget(
                          title: 'actual',
                          angle: actualValue,
                          fontSize: annotationFontSize,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        ContaineredText(text: title, color: Colors.deepOrange, fontSize: 15),
      ],
    );
  }
}
