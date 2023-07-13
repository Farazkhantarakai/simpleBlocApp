import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/userlogged/userlogevent.dart';
import 'package:simplebloc/blocs/userlogged/userlogstate.dart';

class UserLoggedInBloc extends Bloc<UserLogEvent, UserLogstate> {
  UserLoggedInBloc() : super(UserLogOutState()) {
    on<UserLogIn>((event, emit) {
      if (event.tokenId != '') {
        emit(UserLogInState('success'));
      } else {
        emit(UserLogOutState());
      }
    });
  }
}
