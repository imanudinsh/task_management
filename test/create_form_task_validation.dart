import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_management/domain/usecases/task_use_cases.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/pages/create_task_page.dart';
import 'package:task_management/presentation/widgets/primary_button.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

GetIt getIt = GetIt.instance;

void setUpGetItForTest() {
  getIt.reset();
  getIt.registerLazySingleton<TaskRepository>(() => MockTaskRepository());
  getIt.registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase(getIt()));
  getIt.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase(getIt()));
  getIt.registerLazySingleton<SortTasksUseCase>(() => SortTasksUseCase(getIt()));
  getIt.registerLazySingleton<SearchTasksUseCase>(() => SearchTasksUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTaskUseCase>(() => UpdateTaskUseCase(getIt()));
  getIt.registerLazySingleton<DeleteTaskUseCase>(() => DeleteTaskUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTaskStatusUseCase>(() => UpdateTaskStatusUseCase(getIt()));
  getIt.registerLazySingleton<SyncPendingTasksUseCase>(() => SyncPendingTasksUseCase(getIt()));
}

void main() {
  group('AddTaskForm Validation', () {
    late TaskBloc taskBloc;

    setUp(() {
      setUpGetItForTest();
      getIt.registerLazySingleton<TaskBloc>(() => TaskBloc());
    });

    testWidgets('should show error messages when fields are empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: getIt<TaskBloc>(),
            child: const CreateTaskPage(),
          ),
        ),
      );

      // Tap the submit button without entering any data
      await tester.press(find.byElementType(ButtonStyleButton));
      await tester.pump();

      // Verify that error messages are displayed
      expect(find.text('Please enter Title'), findsOneWidget);
      expect(find.text('Please enter Description'), findsOneWidget);
    });

    testWidgets('Title length no more than 30 char', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: getIt<TaskBloc>(),
            child: const CreateTaskPage(),
          ),
        ),
      );

      // Enter a title that is too short
      await tester.enterText(find.byType(TextField).first, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat');

      // Verify that Title length no more than 30 char
      // expect(find.text('Title must be at least 3 characters long'), findsOneWidget);
    });

    // Add more test cases for other validation rules
  });
}