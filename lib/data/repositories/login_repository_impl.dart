import 'package:task_management/data/datasources/remote/endpoint.dart';
import 'package:task_management/data/datasources/remote/network_service.dart';
import 'package:task_management/data/model/login_model.dart';
import 'package:task_management/domain/entities/login_entity.dart';
import 'package:task_management/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkService networkService;
  
  LoginRepositoryImpl({required this.networkService});
  
  @override
  Future<LoginEntity> login(String email, String password) async {
    final response = await networkService.insertData(
      Endpoint.login,
        {
          "email": email,
          "password": password,
        }
    );

    if (response.statusCode == 200) {
      final loginModel = LoginModel.fromJson(response.data);
      return loginModel;
    } else if (response.statusCode == 400) {
      final loginModel = LoginModel.fromJson(response.data);
      return loginModel;
    } else {
      throw Exception('Login failed with status code: ${response.statusCode}');
    }
  }
}