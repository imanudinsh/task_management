import 'package:flutter/material.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/presentation/pages/home_page.dart';
import 'package:task_management/presentation/pages/login_page.dart';
import 'package:task_management/presentation/pages/create_task_page.dart';
import 'package:task_management/presentation/pages/splash_screen.dart';
import 'package:task_management/presentation/pages/update_task_page.dart';
import 'package:task_management/presentation/routes/pages.dart';


Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.initial:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case Pages.login:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case Pages.createNewTask:
      return MaterialPageRoute(
        builder: (context) => const CreateTaskPage(),
      );
    case Pages.updateTask:
      final args = routeSettings.arguments as Task;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskPage(taskModel: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  }
}
