import 'dart:async';

import 'package:bloc/bloc.dart';
part 'auth_state.dart';

class AuthBloc
    extends Cubit<AuthState> {

  AuthBloc():  super(AuthenticationInitial());

  void unAuthenticatedEvent(){
    emit(UnAuthenticatedState());
  }
  void AuthenticatedEvent(){
    emit(AuthenticatedState());
  }

}
