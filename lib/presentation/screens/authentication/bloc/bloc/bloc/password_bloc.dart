// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitialState(false)) {
    on<PasswordVisible>(
        (event, emit) => emit(PasswordShowState(showStatus: true)));
    on<PasswordInvisible>(
        (event, emit) => emit(PasswordHideState(showStatus: false)));
  }
}
