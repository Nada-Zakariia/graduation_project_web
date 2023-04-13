abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppHoverState extends AppStates {}

class AppSelectState extends AppStates {}

class AppIndicatorState extends AppStates {}

class DataArrivalState extends AppStates {}

// class GetTrainsSuccessState extends AppStates {}

// class GetTrainsErrorState extends AppStates {
//   final error;

//   GetTrainsErrorState(this.error);

// }

// class GetTrainsLoadingState extends AppStates {}

// class GetStationNameSuccessState extends AppStates {}

// class GetStationNameErrorState extends AppStates {
//   final error;
//   GetStationNameErrorState(this.error);
// }

// class GetStationNameLoadingState extends AppStates {}

class GetSeatsSuccessState extends AppStates {}

class GetSeatsErrorState extends AppStates {
  final error;

  GetSeatsErrorState(this.error);
}
