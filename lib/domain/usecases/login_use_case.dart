import 'package:task_management/domain/entities/login_entity.dart';
import 'package:task_management/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<LoginEntity> execute(String email, String password) async {
    return await loginRepository.login(email, password);
  }
}