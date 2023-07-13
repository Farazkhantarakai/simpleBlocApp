import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/data/repository/authrepository.dart';
import 'package:simplebloc/presentation/screens/authentication/bloc/signinevent.dart';
import 'package:simplebloc/presentation/screens/authentication/bloc/signinstate.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Bloc<SignInEvent, SigninState> {
  final AuthRepository authRepository;
  SignInBloc(this.authRepository) : super(SigninInitialState()) {
    on<SigninDataChangeEvent>((event, emit) {
      if (EmailValidator.validate(event.email.toString()) == false) {
        return emit(SignInErrorState('please enter a  valid email'));
      } else if (event.password.isEmpty) {
        return emit(SignInErrorState('Password Field is empty'));
      } else if (!event.password.contains(RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
        return emit(SignInErrorState('Try to choose strong password'));
      } else {
        return emit(SignInValidState());
      }
    });
    on<SignInButtonEvent>((event, emit) async {
      emit(SignInLoadingState());
      try {
        String result =
            await authRepository.authenticateUser(event.email, event.password);

        if (result.toString().isNotEmpty) {
          SharedPreferences spf = await SharedPreferences.getInstance();
          await spf.setString('userResult', result);
          emit(SignedInUser(result.toString()));
        } else {
          emit(SignedOutUser());
        }
      } catch (err) {
        rethrow;
      }
    });
  }
}
