import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:task_management/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:task_management/presentation/blocs/login_bloc/login_event.dart';
import 'package:task_management/presentation/blocs/login_bloc/login_state.dart';
import 'package:task_management/presentation/routes/pages.dart';
import 'package:task_management/presentation/widgets/edit_text_field.dart';
import 'package:task_management/presentation/widgets/primary_button.dart';
import 'package:task_management/utils/color_palette.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              // Navigate to the next screen
              // context.read<AuthBloc>().AuthenticatedEvent();
              SpUtil.putBool("IS_LOGIN", true);
              var isLogin = SpUtil.getBool("IS_LOGIN") ?? false;
              debugPrint("IS LOGIN ${isLogin}");
              Navigator.of(context).pushReplacementNamed(Pages.home);
            } else if (state is LoginFailure) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: state.error,
                ),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SvgPicture.asset( "assets/images/illustration_2.svg", width: 200,),
                      ),
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height - 30
                            ),
                            child:  Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const Text("Welcome Back,", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColorPalette.text),),
                                  const Text("Log in now to continue", style: TextStyle(color: ColorPalette.textPassive),),
                                  const SizedBox(height: 60),
                                  state is LoginFailure? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(state.error, style: const TextStyle(color: ColorPalette.lightRed),),
                                  ): const SizedBox.shrink(),
                                  EditTextField(
                                    title: "Email",
                                    textController: _emailController,
                                    icon: SvgPicture.asset( "assets/images/ic_envelope.svg", width: 18, color: ColorPalette.text),
                                    enabled: true,
                                  ),
                                  const SizedBox(height: 20),
                                  EditTextField(
                                    title: "Password",
                                    textController: _passwordController,
                                    icon: SvgPicture.asset( "assets/images/ic_lock.svg", width: 20, color: ColorPalette.text),
                                    enabled: true,
                                  ),
                                  const SizedBox(height:30),

                                  state is LoginLoading ? Center( child: const CircularProgressIndicator() )
                                      : SizedBox(
                                    width: double.infinity,
                                    height:55,
                                    child: PrimaryButton(title: "Log in", onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Process login
                                        context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    }),
                                  ),

                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  )
                );
              }
              ),
        )
    );
  }
}