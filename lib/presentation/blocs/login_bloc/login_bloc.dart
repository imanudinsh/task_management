import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/usecases/login_use_case.dart';
import 'package:task_management/presentation/blocs/login_bloc/login_event.dart';
import 'package:task_management/presentation/blocs/login_bloc/login_state.dart';
import 'package:task_management/injection.dart' as di;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase = di.locator.get<LoginUseCase>();

  LoginBloc()
      : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await loginUseCase.execute(
          event.email,
          event.password,
        );
        emit(LoginSuccess(result));
      } catch (error) {
        var message = error.toString().replaceAll("Exception: ", '');
        emit(LoginFailure(message));
      }
    });
  }
}