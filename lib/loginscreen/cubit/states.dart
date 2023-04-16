
abstract class LoginStates {}
class PassIsVisibleState extends LoginStates{}
class LoginInitialState extends LoginStates {}
class LoginLoadinglState extends LoginStates {}
class LoginSucessState extends LoginStates {
  //final loginModel model;
  //loginSucessState(this.model);
}
class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class OnFocusState extends LoginStates{}

class GetStationNameSuccessState extends LoginStates {}

class GetStationNameErrorState extends LoginStates {
  final error;
  GetStationNameErrorState(this.error);
}

class GetStationNameLoadingState extends LoginStates {}
class GetTrainsLoadingState extends LoginStates {}


class GetTrainsSuccessState extends LoginStates{}
class GetTrainsErrorState extends LoginStates {
  final error;

  GetTrainsErrorState(this.error);
  
}

class SlctUnslctSuccessState extends LoginStates {}
