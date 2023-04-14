import 'dart:async';

abstract class payStates {}

class payInitialState extends payStates {}

class getUserLoadinglState extends payStates {}

class getUserSuccesslState extends payStates {}

class getUserErrorState extends payStates {
  final String error;
  getUserErrorState(this.error);
}
class paySuccesslState extends payStates {}

class payErrorState extends payStates {
  final String error;
  payErrorState(this.error);
}
