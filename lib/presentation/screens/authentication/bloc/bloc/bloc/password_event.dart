part of 'password_bloc.dart';

abstract class PasswordEvent {}

class PasswordVisible extends PasswordEvent {
  bool checkValue;
  PasswordVisible(this.checkValue);
}

class PasswordInvisible extends PasswordEvent {
  bool checkValue;
  PasswordInvisible(this.checkValue);
}
