import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sp_util/sp_util.dart';
import 'package:task_management/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/routes/app_router.dart';
import 'package:task_management/presentation/routes/pages.dart';
import 'package:task_management/utils/color_palette.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  /// {@macro app}
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.colorPrimary),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: ColorPalette.text, // Visible even when not focused
        ),
      ),
      initialRoute: Pages.initial,
      onGenerateRoute: onGenerateRoute,

    );
  }
}

