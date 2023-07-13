class UserLogEvent {}

class UserLogOut extends UserLogEvent {}

class UserLogIn extends UserLogEvent {
  String tokenId;
  UserLogIn(this.tokenId);
}
