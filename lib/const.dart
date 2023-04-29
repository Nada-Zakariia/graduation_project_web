import 'package:control_page/homescreen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

class ColorTheme {
  // static const Color mainBlue = Colors.orange;
  static const Color primaryColor = Color(0xFF7E57C2);
  static const Color blueGray = Color.fromRGBO(236, 239, 241, 1);
  static const Color saimon = Color.fromARGB(255, 252, 120, 105);
  static const Color black = Colors.black;
  static const Color white = Color(0xFFEEEEEE);
  static const Color gold = Color.fromARGB(255, 255, 208, 128);
  static const Color green = Color.fromARGB(255, 95, 222, 101);
  static const Color lightGray = Color.fromRGBO(125, 123, 123, 1);
}

bool isHover = false;
Color menuTextColor = Colors.white;
Color pageTextColor = Colors.black;
Color textColor = ColorTheme.primaryColor;
Color textBackground = Colors.white;
Color flameIndicator = ColorTheme.primaryColor;
Color lightIndicator = ColorTheme.primaryColor;
IconData doorLock = Icons.lock;
var itemHover;
var itemSelect = 0;
var selectedTrainName = 'Train1';
double tempValue = 0;
double humValue = 0;
bool flameState = false;
bool doorLockState = false;
bool lightState = false;
String trainNum=trains[0]["trainNum"].toString();
// bool isHidden = false;
List allTrains = [];
DateTime now = DateTime.now();
dynamic date = DateFormat.yMMMEd().format(now);

String trainId = trains[0]['trainID'];
List trains = [];
var numberOfBookedSeats = 0;
var numberOfAvailableSeats = 0;
String stationName = 'Alexandria';
MqttBrowserClient client=MqttBrowserClient('ws://test.mosquitto.org', '') ;
AppCubit ?cubic ;