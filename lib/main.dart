import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/postbloc/postbloc.dart';
import 'package:simplebloc/blocs/updatebloc/updatebloc.dart';
import 'package:simplebloc/data/repository/authrepository.dart';
import 'package:simplebloc/data/repository/postrepository.dart';
import 'package:simplebloc/presentation/screens/signinscreen.dart';
import 'presentation/screens/authentication/bloc/bloc/bloc/password_bloc.dart';
import 'presentation/screens/authentication/bloc/signinbloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordBloc>(create: (context) => PasswordBloc()),
        BlocProvider(create: (context) => SignInBloc(AuthRepository())),
        BlocProvider<PostBloc>(create: (context) => PostBloc(PostRepository())),
        BlocProvider<UpdateBloc>(
            create: (context) => UpdateBloc(PostRepository()))
      ],
      child: const GetMaterialApp(home: LogInScreen()),
    );
  }
}
