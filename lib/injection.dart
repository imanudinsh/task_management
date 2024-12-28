import 'package:get_it/get_it.dart';
import 'package:task_management/data/datasources/local/database_helper.dart';
import 'package:task_management/data/datasources/remote/network_service.dart';
import 'package:task_management/data/repositories/login_repository_impl.dart';
import 'package:task_management/data/repositories/task_repository_impl.dart';
import 'package:task_management/domain/repositories/login_repository.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/domain/usecases/login_use_case.dart';
import 'package:task_management/domain/usecases/task_use_cases.dart';

final locator = GetIt.instance;

void init() {

  // use cases
  locator.registerLazySingleton(() => LoginUseCase(
      loginRepository: locator()
  ));
  locator.registerLazySingleton(() => AddTaskUseCase(locator()));
  locator.registerLazySingleton(() => GetTasksUseCase(locator()));
  locator.registerLazySingleton(() => SearchTasksUseCase(locator()));
  locator.registerLazySingleton(() => SortTasksUseCase(locator()));
  locator.registerLazySingleton(() => UpdateTaskUseCase(locator()));
  locator.registerLazySingleton(() => DeleteTaskUseCase(locator()));
  locator.registerLazySingleton(() => UpdateTaskStatusUseCase(locator()));
  locator.registerLazySingleton(() => SyncPendingTasksUseCase(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
      networkService: locator(),
    ),
  );
  locator.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(
      databaseHelper: locator(),
      networkService: locator(),
    ),
  );

  // services
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => DatabaseHelper.instance);

}
