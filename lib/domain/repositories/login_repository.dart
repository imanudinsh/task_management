import 'package:task_management/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(String email, String password);
}