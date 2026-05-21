import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/core/widgets/app_button.dart';
import 'package:doctor/core/widgets/app_text_feild.dart';
import 'package:doctor/core/widgets/pass_txt_feild.dart';
import 'package:doctor/features/auth/register/data/user_model.dart';
import 'package:doctor/features/auth/register/logic/register_cubit.dart';
import 'package:doctor/features/auth/register/logic/register_state.dart';
import 'package:doctor/features/home/presentation/screens/home_screen.dart' show HomeScreen;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController emailController =  TextEditingController();
  TextEditingController nameController =  TextEditingController();

  TextEditingController phoneNumberController =  TextEditingController();
  TextEditingController genderController =  TextEditingController();

  TextEditingController passwordController =  TextEditingController();

  TextEditingController passwordConfirmationController =  TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterSuccessState){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen(userName: state.userName)));
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
    else if(state is RegisterErrorState){
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
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:32,vertical: 64 ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create Account",style: TxtStyle.font24weight700,),
              Text("Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",style: TxtStyle.font14weight400,),
              AppTextFeild(


                hintText:"Email" , textEditingController: emailController, ),
              AppTextFeild(hintText:"Name" , textEditingController: nameController),
              AppTextFeild(hintText:"Phone Number" , textEditingController: phoneNumberController),
              AppTextFeild(hintText:"Gender" , textEditingController: genderController),
              PassTxtFeild(textEditingController: passwordController, hintTxt: "Password"),
              PassTxtFeild(textEditingController: passwordConfirmationController, hintTxt: "Password Confirmation"),


              (state is RegisterLoadingState)?Center(child:CircularProgressIndicator()):AppButton(buttonTxt:"create account",function:(){


                context.read<RegisterCubit>().register(UserModel(email: emailController.text, name:nameController.text, gender: genderController.text, phone: phoneNumberController.text, password: passwordController.text, passwordConfirmation: passwordConfirmationController.text),);
              })


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
