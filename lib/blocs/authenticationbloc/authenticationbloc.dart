import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc {
  Stream<String> get isAuthenticated async* {
    final String hasToken = await getToken();
    debugPrint(hasToken.toString());
    yield hasToken;
  }

  Future<String> getToken() async {
    SharedPreferences spf = await SharedPreferences.getInstance();

    String? data = spf.getString('token');
    debugPrint(data);
    return data!;
  }

  Future<void> persistToken(String token) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString('token', token);
  }

  Future<void> clearToken() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove('token');
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:simplebloc/blocs/authenticationbloc/authenticationevent.dart';
// import 'package:simplebloc/blocs/authenticationbloc/authenticationstate.dart';
// class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
// }
