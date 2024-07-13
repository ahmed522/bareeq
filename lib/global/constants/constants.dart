class AppConstants {
  static const String linearVelocityTopic = '/robot/linear_velocity';
  static const String baseJointAngleTopic = '/robot/base_joint_angle';
  static const String elbowJointAngleTopic = '/robot/elbow_joint_angle';
  static const String mapTopic = '/robot/map';
  static const String odomTopic = '/robot/odom';
  static const String baseJointAngleCommandTopic =
      '/app/base_joint_angle_command';
  static const String elbowJointAngleCommandTopic =
      '/app/elbow_joint_angle_command';
  static const String brushCommandTopic = '/app/brush_command';
  static const String joystickTopic = '/app/joystick';
  static const String robotLastWillTopic = '/robot/lastWill';
  static const String robotLastWillMessage = 'robot disconnected';
  static const List<String> neededTopics = [
    linearVelocityTopic,
    joystickTopic,
    mapTopic,
    odomTopic,
    baseJointAngleCommandTopic,
    elbowJointAngleCommandTopic,
    baseJointAngleTopic,
    elbowJointAngleTopic,
    brushCommandTopic,
    robotLastWillTopic,
  ];
}
