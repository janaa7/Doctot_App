import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/core/widgets/app_button.dart';
import 'package:doctor/core/widgets/app_text_feild.dart';
import 'package:doctor/features/auth/login/data/login_model.dart' show LoginModel;
import 'package:doctor/features/auth/login/logic/login_cubit.dart';
import 'package:doctor/features/auth/login/logic/login_state.dart';
import 'package:doctor/features/auth/register/data/user_model.dart';
import 'package:doctor/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =  TextEditingController();

  TextEditingController passwordController =  TextEditingController();
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
    if(state is LoginSuccessState){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(userName: emailController.text.trim())));


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Account created successfully",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorManager.blue,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
    else if(state is LoginErrorState){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorManager.blue,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );




    }
  },
  builder: (context, state) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:32,vertical: 64 ),
        child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back",style: TxtStyle.font24weight700,),
            Text("We're excited to have you back, can't wait to see what you've been up to since you last logged in.",style: TxtStyle.font14weight400,),

            AppTextFeild(


              hintText:"Email" , textEditingController: emailController, ),


            AppTextFeild(


              hintText:"password" , textEditingController: passwordController, ),

            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                Text("Remember me",style: TxtStyle.font14weight500,),
                SizedBox(width:80),
                Text("Forget Password?",style: TxtStyle.font12weight400)
              ],


            ),


            AppButton(
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

          ]
        ),
      )
      ,
    );
  },
),
);
  }
}
