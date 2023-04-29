import 'dart:async';
import 'package:control_page/const.dart';
import 'package:control_page/homescreen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
class MqttHandler with ChangeNotifier {
  final ValueNotifier<String> data = ValueNotifier<String>("");
  Future<int> connect() async {
    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 60;
    client.connectTimeoutPeriod = 2000; // milliseconds
    client.port = 8080;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
        'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
      return -1;
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client
              .connectionStatus}');
      client.disconnect();
      return -1;
    }
     sub();
    // print('EXAMPLE::Sleeping....');
    // await MqttUtilities.asyncSleep(60);
    // print('EXAMPLE::Unsubscribing');
    // client.unsubscribe(topic);
    // await MqttUtilities.asyncSleep(2);
    // print('EXAMPLE::Disconnecting');
    // client.disconnect();
    return 0;
  }
void sub()async{
  String topic = 'Train $trainNum'; // Not a wildcard topic
  print('EXAMPLE::Subscribing to the $topic topic');
  client.subscribe(topic, MqttQos.atMostOnce);
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
    MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    data.value = pt;
    List l=pt.split(",");
    String sensor=l[0];
    double sensorData =double.parse(l[1]);
    if (sensor=='0') {
      tempValue =sensorData;
    } else if (sensor=='1') {
      humValue = sensorData;
    } else if (sensor=='2') {
      flameState=(sensorData==0)?false:true;
    } else if (sensor=='3') {
      doorLockState = (sensorData==0)?false:true;
    } else if (sensor=='4') {
      lightState = (sensorData==0)?false:true;
    }
    print(
        'EXAMPLE::Change notification:: topic is <${c[0]
            .topic}>, payload is <-- $pt -->');
    print('');
    cubic!.emit(DataArrivalState());
  });


  client.published!.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader!
            .topicName}, with Qos ${message.header!.qos}');
  });
}

void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  connect();
  if (client.connectionStatus!.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::OnDisconnected callback is solicited, this is correct');

  }
}

void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was sucessful');
}

void pong() {
  print('EXAMPLE::Ping response client callback invoked');
}}