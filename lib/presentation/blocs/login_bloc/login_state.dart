import 'package:equatable/equatable.dart';
import 'package:task_management/domain/entities/login_entity.dart';
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  const LoginSuccess(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}