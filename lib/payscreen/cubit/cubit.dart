import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_page/payscreen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class payCubit extends Cubit<payStates> {
  payCubit() : super(payInitialState());
  static payCubit get(context) => BlocProvider.of(context);

  var snapshot;
  late UserModel user;
  late String start;

  Future<bool> searchNumber({
    required String number,
  }) async {
    emit(getUserLoadinglState());
    start = number.substring(0, 3);
    FirebaseFirestore.instance
        .collection("users")
        .doc(start)
        .collection('numbers')
        .doc(number)
        .get()
        .then((value) {
      snapshot = value;
      user = UserModel.fromJason(value.data()!);
      emit(getUserSuccesslState());
      return snapshot.exists;
    }).catchError((e) {
      emit(getUserErrorState(e.toString()));
    });
    return false;
  }

  Future<void> updateBalance(String number) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(start)
        .collection('numbers')
        .doc(number)
        .set({"bill": "0"}, SetOptions(merge: true)).then((value) {
      emit(paySuccesslState());
      searchNumber(number: number);
    }).catchError((e) {
      emit(payErrorState(e.toString()));
    });
  }
}
