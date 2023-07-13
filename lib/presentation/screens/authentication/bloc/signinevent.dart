abstract class SignInEvent {}

class SigninDataChangeEvent extends SignInEvent {
  final String email;
  final String password;
  SigninDataChangeEvent(this.email, this.password);
}

class SignInButtonEvent extends SignInEvent {
  final String email;
  final String password;
  SignInButtonEvent(this.email, this.password);
}
