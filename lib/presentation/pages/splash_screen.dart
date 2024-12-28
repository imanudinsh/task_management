import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:task_management/presentation/routes/pages.dart';
import 'package:task_management/presentation/widgets/text_view.dart';
import 'package:task_management/utils/color_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      var isLogin = SpUtil.getBool("IS_LOGIN") ?? false;
      if (isLogin) {
        Navigator.pushNamedAndRemoveUntil( context, Pages.home, (route) => false );
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Pages.login, (route) => false );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.colorPrimary,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/illustration_1.svg", width: 160,),
                const SizedBox(height: 20,),
                TextView('Simplify Your Workflow', Colors.white, 24,
                    FontWeight.w600, TextAlign.center, TextOverflow.clip),
                const SizedBox(
                  height: 10,
                ),
                TextView(
                    'Task Management for Seamless Productivity', Colors.white,
                    12,
                    FontWeight.normal, TextAlign.center, TextOverflow.clip),
              ],
            )));
  }
}
