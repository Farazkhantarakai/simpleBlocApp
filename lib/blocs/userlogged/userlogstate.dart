abstract class UserLogstate {}

class UserLogInState extends UserLogstate {
  final String status;
  UserLogInState(this.status);
}

class UserLogOutState extends UserLogstate {}
