abstract class SigninState {}

class SigninInitialState extends SigninState {}

class SignInValidState extends SigninState {}

class SignIninvalidState extends SigninState {}

class SignInErrorState extends SigninState {
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}

class SignedInUser extends SigninState {
  final String token;
  SignedInUser(this.token);
}

class SignedOutUser extends SigninState {}

class SignInLoadingState extends SigninState {}
