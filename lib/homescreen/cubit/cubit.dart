import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_page/const.dart';
import 'package:control_page/homescreen/cubit/mqtt.dart';
import 'package:control_page/homescreen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  MqttHandler mqtt = MqttHandler();
  void hoverEffect() {
    isHover = !isHover;
    emit(AppHoverState());
  }

  void initialFunction() {
    searchedTrainsList = allTrains;
    searchedTrainsData = trains;
    trainNum = searchedTrainsData[0]["trainNum"].toString();
    trainId = searchedTrainsData[0]['trainID'];
    numberOfAvailableSeats =
        int.parse(searchedTrainsData[0]['available']['${day}']);
    numberOfBookedSeats = 48 - numberOfAvailableSeats;

    scrollController.addListener(() {
      if (scrollController.offset < scrollController.position.maxScrollExtent) {
        isVisable = true;
        emit(ScrollState());
      } else {
        isVisable = false;
        emit(ScrollState());
      }
    });
    emit(AppInitialState());
  }

  void onSearchTextChanged(String text) {
    // print(text);
    searchedTrainsList = [];
    searchedTrainsData = [];
    if (text.isNotEmpty) {
      for (var ele in trains) {
        print(ele['trainNum'].toString().contains(text));
        if (ele['trainNum'].toString().contains(text)) {
          // print(ele);
          // print(ele['trainNum'].toString());
          searchedTrainsData.add(ele);
          searchedTrainsList.add('Train ${ele['trainNum']}');
        }
        // searchController.text = text;
      }
    } else {
      searchedTrainsList = allTrains;
      searchedTrainsData = trains;
    }
    print(searchedTrainsList);
    emit(SearchedTrainSuccessState());
  }

  void ConnectAndGetData() {
    mqtt.connect();
    emit(DataArrivalState());
  }

  void getData() {
    mqtt.sub();
  }

  void selectPage() {
    ConnectAndGetData();
    emit(DataArrivalState());
  }

  void appIndeicator() {
    ConnectAndGetData();

    emit(AppIndicatorState());
  }
}
