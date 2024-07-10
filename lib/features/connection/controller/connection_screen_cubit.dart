import 'dart:async';

import 'package:bareeq/features/connection/controller/connection_screen_states.dart';
import 'package:bareeq/features/connection/view/widgets/new_topic_alert_dialog.dart';
import 'package:bareeq/global/constants/constants.dart';
import 'package:bareeq/global/services/mqtt/mqtt_connection_status.dart';
import 'package:bareeq/global/services/mqtt/mqtt_manager.dart';
import 'package:bareeq/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionScreenCubit extends Cubit<ConnectionScreenStates> {
  final TextEditingController brokerTextController = TextEditingController();
  final TextEditingController portTextController = TextEditingController();
  final TextEditingController topicTextController = TextEditingController();
  MqttConnectionStatus currentAppState = MqttConnectionStatus.notConnected;
  late MQTTManager _manager;

  ConnectionScreenCubit() : super(ConnectionInitState()) {
    _init();
  }
  static ConnectionScreenCubit get(context) => BlocProvider.of(context);
  _init() {}
  addNewTopic(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return NewTopicAlertDialog(subscribe: (topic) => subscribe(topic));
      },
    );
  }

  addNeededTopics() {
    for (String topic in AppConstants.neededTopics) {
      subscribe(topic);
    }
  }

  bool get subscribedToAllNeededTopics {
    for (var neededTopic in AppConstants.neededTopics) {
      if (!subscribedTopics.contains(neededTopic)) {
        return false;
      }
    }
    return true;
  }

  connect(BuildContext context) {
    String brokerIp = brokerTextController.text.trim();
    String port = portTextController.text.trim();
    if (brokerIp == '') {
      AppSnackBar.showSnackBar(context, 'Invalid Broker IP', Colors.red);
      return;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(port)) {
      AppSnackBar.showSnackBar(context, 'Invalid Port', Colors.red);
      return;
    }
    _manager = MQTTManager(cubit: this, host: brokerIp, port: int.parse(port));

    _manager.connect();
  }

  disconnect() {
    _manager.disconnect();
  }

  stop() {
    _manager.disconnect();
  }

  subscribe(String topic) {
    _manager.subscribe(topic);
  }

  unSubscribe(String topic) {
    _manager.unSubscribe(topic);
  }

  unSubscribeAllTopics() {
    for (String topic in subscribedTopics) {
      _manager.unSubscribe(topic);
    }
  }

  publishJoystickData(String data) {
    _manager.publish(AppConstants.joystickTopic, data);
  }

  publishBaseAngleData(String data) {
    _manager.publish(AppConstants.baseJointAngleCommandTopic, data);
  }

  publishElbowAngleData(String data) {
    _manager.publish(AppConstants.elbowJointAngleCommandTopic, data);
  }

  emitState(ConnectionScreenStates state) => emit(state);
  MqttConnectionStatus get connectionStatus => _manager.state;
  List<String> get subscribedTopics => _manager.subscripedTopics;
  Stream<Map<String, dynamic>> get messages => _manager.messages;
}
