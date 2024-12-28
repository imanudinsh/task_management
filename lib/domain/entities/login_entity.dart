import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? error;
  final String? token;

  const LoginEntity({this.token, this.error});

  @override
  List<Object?> get props => [token, error];
}