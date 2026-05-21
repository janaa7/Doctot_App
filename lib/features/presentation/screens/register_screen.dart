import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/core/widgets/app_button.dart';
import 'package:doctor/core/widgets/app_text_feild.dart';
import 'package:doctor/core/widgets/pass_txt_feild.dart';
import 'package:doctor/features/auth/register/data/user_model.dart';
import 'package:doctor/features/auth/register/logic/register_cubit.dart';
import 'package:doctor/features/auth/register/logic/register_state.dart';
import 'package:doctor/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(userName: state.userName),
              ),
            );
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: ColorManager.blue,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    Text("Create Account", style: TxtStyle.font24weight700),

                    const SizedBox(height: 10),

                    Text(
                      "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                      style: TxtStyle.font14weight400,
                    ),

                    const SizedBox(height: 18),

                    AppTextFeild(
                      hintText: "Email",
                      textEditingController: emailController,
                    ),

                    const SizedBox(height: 8),

                    AppTextFeild(
                      hintText: "Name",
                      textEditingController: nameController,
                    ),
                    const SizedBox(height: 8),

                    AppTextFeild(
                      hintText: "Phone Number",
                      textEditingController: phoneNumberController,
                    ),

                    const SizedBox(height: 8),

                    AppTextFeild(
                      hintText: "Gender",
                      textEditingController: genderController,
                    ),

                    const SizedBox(height: 8),

                    PassTxtFeild(
                      textEditingController: passwordController,
                      hintTxt: "Password",
                    ),

                    const SizedBox(height: 8),

                    PassTxtFeild(
                      textEditingController: passwordConfirmationController,
                      hintTxt: "Password Confirmation",
                    ),

                    const SizedBox(height: 14),

                    state is RegisterLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                      buttonTxt: "create account",
                      function: () {
                        context.read<RegisterCubit>().register(
                          UserModel(
                            email: emailController.text.trim(),
                            name: nameController.text.trim(),
                            gender: genderController.text.trim(),
                            phone: phoneNumberController.text.trim(),
                            password: passwordController.text,
                            passwordConfirmation:
                            passwordConfirmationController.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or sign in with",
                            style: TxtStyle.font12weight400grey,
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          width: 44,
                          height: 44,
                        ),
                        const SizedBox(width: 22),
                        Image.asset(
                          "assets/images/facebook.png",
                          width: 44,
                          height: 44,
                        ),
                        const SizedBox(width: 22),
                        Image.asset(
                          "assets/images/apple.png",
                          width: 44,
                          height: 44,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "By logging, you agree to our ",
                          style: TxtStyle.font12weight400black,
                        ),
                        Text(
                          "Terms & Conditions",
                          style: TxtStyle.font12weight400.copyWith(
                            color: ColorManager.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Center(
                      child: Text(
                        "and PrivacyPolicy.",
                        style: TxtStyle.font12weight400black,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TxtStyle.font12weight400black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TxtStyle.font12weight400.copyWith(
                              color: ColorManager.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}