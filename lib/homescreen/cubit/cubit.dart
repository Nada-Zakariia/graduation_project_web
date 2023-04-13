import 'package:control_page/const.dart';
import 'package:control_page/homescreen/cubit/mqtt.dart';
import 'package:control_page/homescreen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  MqttHandler mqtt=MqttHandler();
  void hoverEffect() {
    isHover = !isHover;
    emit(AppHoverState());
  }
 void ConnectAndGetData(){
    mqtt.connect();
 }
  void getData(){
    mqtt.sub();
  }
  void selectPage() {
    // trainId = trains[itemSelect]['trainID'];
    // getSeats(trainId);
    //print(trains[itemSelect]['trainID']);
    ConnectAndGetData();
  }

  void appIndeicator() {
    ConnectAndGetData();

    emit(AppIndicatorState());
  }


  // void getSeats(String trainId) async {
  //   List seats = [];
  //   numberOfBookedSeats = 0;
  //   numberOfAvailableSeats = 0;
  //   await FirebaseFirestore.instance
  //       .collection('trains')
  //       .doc(trainId)
  //       .collection('seats')
  //       .get()
  //       .then((value) {
  //     print('=====================================');
  //     value.docs.forEach((e) {
  //       seats = e[DateFormat('EEEE').format(now)];
  //     });
  //     for (bool i in seats) {
  //       if (i) {
  //         numberOfBookedSeats += 1;
  //       }
  //     }
  //     numberOfAvailableSeats = 48 - numberOfBookedSeats;
  //     emit(GetSeatsSuccessState());
  //   }).catchError((error) {
  //     emit(GetSeatsErrorState(error.toString()));
  //   });
  // }
}
