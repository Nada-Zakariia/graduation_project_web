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
String trainNum = '';
List<String> allTrains = []; //trains with only names to display
List<String> searchedTrainsList = []; //trains with names resulted by search
List searchedTrainsData = [];
DateTime now = DateTime.now();
dynamic date = DateFormat.yMMMEd().format(now);
String day = DateFormat('EEEE').format(now).toString().substring(0, 3);
String trainId = '';
List trains = []; //trains with data
int numberOfAvailableSeats = 0;
int numberOfBookedSeats = 0;
String stationName = '';
MqttBrowserClient client = MqttBrowserClient('ws://test.mosquitto.org', '');
AppCubit? cubic;
var searchController = TextEditingController();
FocusNode searchFocus = FocusNode();

//scrolling
var scrollController = ScrollController();
var isVisable = true;
