part of 'password_bloc.dart';

abstract class PasswordState {}

class PasswordInitialState extends PasswordState {
  bool showStatus = false;
  PasswordInitialState(this.showStatus);
}

class PasswordShowState extends PasswordState {
  bool? showStatus;
  PasswordShowState({required this.showStatus});
}

class PasswordHideState extends PasswordState {
  bool? showStatus;
  PasswordHideState({required this.showStatus});
}
