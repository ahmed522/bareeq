import 'dart:convert';
import 'dart:math';

import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/teleop/model/brush_operating_mode.dart';
import 'package:bareeq/features/teleop/model/map_mode.dart';
import 'package:bareeq/global/constants/constants.dart';
import 'package:bareeq/global/constants/numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rviz/struct/occupancy_grid.dart';
import 'package:flutter_rviz/struct/pose.dart' as pose;

import 'control_states.dart';

class ControlCubit extends Cubit<ControlStates> {
  ControlCubit(this.connectionCubit) : super(ControlInitState()) {
    _init();
  }

  static ControlCubit get(context) => BlocProvider.of(context);
  final ConnectionScreenCubit connectionCubit;
  double linearVelocity = 0;
  pose.Pose? odom;
  OccupancyGrid? map;
  double baseJointAngle = AppNumbers.baseJointDefaultAngle;
  double baseJointActualAngle = AppNumbers.baseJointDefaultAngle;
  double elbowJointAngle = AppNumbers.elbowJointDefaultAngle;
  double elbowJointActualAngle = AppNumbers.elbowJointDefaultAngle;
  BrushOperatingMode brushMode = BrushOperatingMode.off;
  MapMode mapMode = MapMode.update;
  bool brushMotorInRest = false;
  bool getMap = false;
  Size? mapCanvasSize;
  _init() {
    connectionCubit.messages.listen((data) {
      if (data.containsKey(AppConstants.linearVelocityTopic)) {
        linearVelocity = double.parse(data[AppConstants.linearVelocityTopic]);
      } else if (data.containsKey(AppConstants.baseJointAngleTopic)) {
        baseJointActualAngle =
            double.parse(data[AppConstants.baseJointAngleTopic]);
      } else if (data.containsKey(AppConstants.elbowJointAngleTopic)) {
        elbowJointActualAngle =
            double.parse(data[AppConstants.elbowJointAngleTopic]);
      } else if (data.containsKey(AppConstants.mapTopic)) {
        if (mapMode != MapMode.hide) {
          if (mapMode == MapMode.update) {
            map = _occupancyGridFromJson(data[AppConstants.mapTopic]);
          } else if (mapMode == MapMode.dontUpdate && !getMap) {
            map = _occupancyGridFromJson(data[AppConstants.mapTopic]);
            getMap = true;
          }
        }
      } else if (data.containsKey(AppConstants.odomTopic)) {
        odom = _odomFromJson(data[AppConstants.odomTopic]);
      }
      if (!isClosed) {
        emit(ControlConnectedState());
      }
    });
  }

  updateBaseJointAngle(double newValue) {
    baseJointAngle = newValue;
    emit(ControlConnectedState());
  }

  updateElbowJointAngle(double newValue) {
    elbowJointAngle = newValue;
    emit(ControlConnectedState());
  }

  updateBrushMode(BrushOperatingMode newMode) {
    brushMode = newMode;
    emit(ControlConnectedState());
  }

  updateBrushMotorInRest(bool value) {
    brushMotorInRest = value;
    emit(ControlConnectedState());
  }

  updateMapCanvasSize(double width, double height) {
    mapCanvasSize = Size(width, height);
    emit(ControlConnectedState());
  }

  sendJoystickData(double x, double y) {
    if (robotOrientation == null) {
      return;
    }
    double r = sqrt((x * x) + (y * y));
    double theta = atan2(y, x);
    if (theta < 0) theta += 2 * pi;
    final json = {
      'r': r,
      'theta': theta,
      'orientation': robotOrientation! * pi / 180,
    };
    final data = jsonEncode(json);
    connectionCubit.publishJoystickData(data);
  }

  moveBack() {
    final json = {
      'r': -0.3,
      'theta': robotOrientation! * pi / 180,
      'orientation': robotOrientation! * pi / 180,
    };
    final data = jsonEncode(json);
    connectionCubit.publishJoystickData(data);
  }

  sendBaseAngleData() {
    connectionCubit.publishBaseAngleData(baseJointAngle.toString());
  }

  sendElbowAngleData() {
    connectionCubit.publishElbowAngleData(elbowJointAngle.toString());
  }

  pose.Pose _odomFromJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    pose.Pose location = pose.Pose(
        position: pose.Position(
          x: jsonData['position']['x'],
          y: jsonData['position']['y'],
          z: jsonData['position']['z'],
        ),
        orientation: pose.Orientation(
          x: jsonData['orientation']['x'],
          y: jsonData['orientation']['y'],
          z: jsonData['orientation']['z'],
          w: jsonData['orientation']['w'],
        ));

    return location;
  }

  OccupancyGrid _occupancyGridFromJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final header = Header(
      frameId: jsonData['header']['frame_id'],
      stamp: Stamp(
        sec: jsonData['header']['stamp']['secs'],
        nanosec: jsonData['header']['stamp']['nsecs'],
      ),
    );

    final info = MapMetaData(
      resolution: jsonData['info']['resolution'].toDouble(),
      width: jsonData['info']['width'],
      height: jsonData['info']['height'],
      origin: pose.Pose(
        position: pose.Position(
          x: jsonData['info']['origin']['position']['x'],
          y: jsonData['info']['origin']['position']['y'],
          z: jsonData['info']['origin']['position']['z'],
        ),
        orientation: pose.Orientation(
          x: jsonData['info']['origin']['orientation']['x'],
          y: jsonData['info']['origin']['orientation']['y'],
          z: jsonData['info']['origin']['orientation']['z'],
          w: jsonData['info']['origin']['orientation']['w'],
        ),
      ),
    );

    final data = List<int>.from(jsonData['data']);

    return OccupancyGrid(
      header: header,
      data: data,
      mapMetaData: info,
    );
  }

  updateMapMode(int index) {
    mapMode = MapMode.values[index];
    emit(ControlConnectedState());
  }

  double? get robotOrientation =>
      (odom == null) ? null : _getYawFromQuaternion(odom!.orientation);
  double _getYawFromQuaternion(pose.Orientation quaternion) {
    double sinyCosp =
        2 * (quaternion.w * quaternion.z + quaternion.x * quaternion.y);
    double cosyCosp =
        1 - 2 * (quaternion.y * quaternion.y + quaternion.z * quaternion.z);
    double yaw = atan2(sinyCosp, cosyCosp);
    return yaw * 180 / pi;
  }
}
