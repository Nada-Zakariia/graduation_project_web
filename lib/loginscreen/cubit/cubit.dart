import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_page/homescreen/cubit/states.dart';
import 'package:control_page/homescreen/home_layout.dart';
import 'package:control_page/loginscreen/cubit/states.dart';
import 'package:control_page/models/train_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_page/const.dart';
import 'package:intl/intl.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);



  bool isHidden = true;
  void visiblePassword() {
    isHidden = !isHidden;
    emit(PassIsVisibleState());
  }

  void onFocus(FocusNode myFocusNode, BuildContext context) {
    FocusScope.of(context).requestFocus(myFocusNode);
    emit(OnFocusState());
  }

  void login(String password, BuildContext context) {
    String stationName = '';
    emit(LoginLoadinglState());
    FirebaseFirestore.instance
        .collection('stations')
        .doc(password)
        .get()
        .then((doc) {
      stationName = doc['name'];
      getTrainsOfStation(stationName, context);
      emit(LoginSucessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  Future<void> getTrainsOfStation(
      String stationName, BuildContext context) async {
    emit(GetTrainsLoadingState());
    FirebaseFirestore.instance
        .collection('trains')
        .where("stations", arrayContains: stationName)
        .snapshots()
        .listen((event) {
      event.docs.forEach((train) {
        trains.add(TrainModel.fromjson(train.data()).toMap());
      });
      trains.forEach((e) {
        allTrains.add('Train ${e['trainNum']}');
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ControlLayout(station:stationName,)),
      );
      emit(GetTrainsSuccessState());
    });
  }
}
