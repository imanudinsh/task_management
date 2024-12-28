import 'package:task_management/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({super.token, super.error});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: json['token'], error: json['error']);
  }
}