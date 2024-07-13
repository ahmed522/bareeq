import 'dart:async';

import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/connection/controller/connection_screen_states.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

import 'mqtt_connection_status.dart';

class MQTTManager {
  final ConnectionScreenCubit _cubit;
  MqttConnectionStatus _currentState = MqttConnectionStatus.notConnected;
  MqttClient? _client;
  final List<String> _subscribedTopics = [];
  late final String _identifier;
  final String _host;
  final int _port;
  final StreamController<Map<String, dynamic>> _messagesController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messages => _messagesController.stream;
  MqttConnectionStatus get state => _currentState;
  List<String> get subscripedTopics => _subscribedTopics;
  MQTTManager(
      {required ConnectionScreenCubit cubit,
      required String host,
      required int port})
      : _cubit = cubit,
        _host = host,
        _port = port,
        _identifier = const Uuid().v4() {
    initializeMQTTClient();
  }

  void initializeMQTTClient() {
    if (kIsWeb) {
      _client = MqttBrowserClient(_host, _identifier);
    } else {
      _client = MqttServerClient(_host, _identifier);
    }

    _client!.port = _port;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    // _client!.secure = false;
    _client!.logging(on: true);
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;
    _client!.onUnsubscribed = onUnsubscribed;
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .startClean()
        .withWillTopic('/app/lastWill')
        .withWillMessage('app disconnected')
        .withWillQos(MqttQos.exactlyOnce);
    _client!.connectionMessage = connMess;
    _client!.setProtocolV311();
  }

  // Connect to the host
  void connect() async {
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _currentState = MqttConnectionStatus.connecting;
      _emitState(ConnectingState());
      await _client!.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String topic, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void subscribe(String topic, [MqttQos qos = MqttQos.atLeastOnce]) {
    _client!.subscribe(topic, qos);
  }

  void unSubscribe(String topic) {
    _client!.unsubscribe(topic);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
    _subscribedTopics.add(topic);
    _currentState = MqttConnectionStatus.subscribed;
    _emitState(SubscribedState());
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      _messagesController.add({c[0].topic: payload});
    });
  }

  void onUnsubscribed(String? topic) {
    print('EXAMPLE::UnSubscription confirmed for topic $topic');
    _subscribedTopics.remove(topic);

    if (_subscribedTopics.isEmpty) {
      if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
        _currentState = MqttConnectionStatus.connected;
        _emitState(ConnectedState());
      } else if (_client!.connectionStatus!.state ==
          MqttConnectionState.connecting) {
        _currentState = MqttConnectionStatus.connecting;
        _emitState(ConnectingState());
      } else {
        _currentState = MqttConnectionStatus.notConnected;
        _emitState(NotConnectedState());
      }
    } else {
      _emitState(SubscribedState());
    }
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState = MqttConnectionStatus.notConnected;
    _emitState(NotConnectedState());
  }

  /// The successful connect callback
  void onConnected() {
    _currentState = MqttConnectionStatus.connected;
    _emitState(ConnectedState());

    print('EXAMPLE::Mosquitto client connected....');
  }

  _emitState(ConnectionScreenStates state) {
    _cubit.emitState(state);
  }
}
