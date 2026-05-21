import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/core/widgets/app_button.dart';
import 'package:doctor/core/widgets/app_text_feild.dart';
import 'package:doctor/core/widgets/pass_txt_feild.dart';
import 'package:doctor/features/auth/login/data/login_model.dart';
import 'package:doctor/features/auth/login/logic/login_cubit.dart';
import 'package:doctor/features/auth/login/logic/login_state.dart';
import 'package:doctor/features/home/presentation/screens/home_screen.dart';
import 'package:doctor/features/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe = true;
      });
    }
  }

  Future<void> saveOrClearData() async {
    final prefs = await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setString("email", emailController.text.trim());
      await prefs.setString("password", passwordController.text);
    } else {
      await prefs.remove("email");
      await prefs.remove("password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  userName: emailController.text.trim(),
                ),
              ),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorManager.blue,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 45),

                    Text(
                      "Welcome Back",
                      style: TxtStyle.font24weight700,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                      style: TxtStyle.font14weight400,
                    ),

                    const SizedBox(height: 32),

                    AppTextFeild(
                      hintText: "Email",
                      textEditingController: emailController,
                    ),

                    const SizedBox(height: 16),

                    PassTxtFeild(
                      hintTxt: "Password",
                      textEditingController: passwordController,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: TxtStyle.font14weight500,
                        ),
                        const Spacer(),
                        Text(
                          "Forgot Password?",
                          style: TxtStyle.font12weight400.copyWith(
                            color: ColorManager.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    state is LoginLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                      buttonTxt: "Login",
                      function: () async {
                        await saveOrClearData();

                        context.read<LoginCubit>().login(
                          LoginModel(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or sign in with",
                            style: TxtStyle.font12weight400,
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialCircle("G"),
                        const SizedBox(width: 24),
                        socialCircle("f"),
                        const SizedBox(width: 24),
                        socialCircle(""),
                      ],
                    ),

                    const SizedBox(height: 32),

                    Center(
                      child: Text(
                        "By logging, you agree to our Terms & Conditions\nand Privacy Policy.",
                        textAlign: TextAlign.center,
                        style: TxtStyle.font12weight400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account yet? ",
                          style: TxtStyle.font12weight400,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TxtStyle.font12weight400.copyWith(
                              color: ColorManager.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget socialCircle(String text) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}