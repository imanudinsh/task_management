part of 'auth_bloc.dart';

abstract class AuthState  {
  const AuthState();
}

class AuthenticationInitial extends AuthState {
}

class AuthenticatedState extends AuthState {
}

class UnAuthenticatedState extends AuthState {
}
