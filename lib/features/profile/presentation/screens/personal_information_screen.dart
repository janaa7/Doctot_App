import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/core/widgets/app_button.dart';
import 'package:doctor/core/widgets/app_text_feild.dart';
import 'package:doctor/core/widgets/pass_txt_feild.dart';
import 'package:doctor/features/profile/data/profile_model.dart';
import 'package:doctor/features/profile/logic/profile_cubit.dart';
import 'package:doctor/features/profile/logic/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInformationScreen extends StatelessWidget {
  final ProfileModel profileModel;

  PersonalInformationScreen({
    super.key,
    required this.profileModel,
  });

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController genderController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = profileModel.name ?? "";
    emailController.text = profileModel.email ?? "";
    phoneController.text = profileModel.phone ?? "";
    genderController.text = profileModel.gender ?? "";

    double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManager.blue,
              ),
            );

            Navigator.pop(context);
          }

          if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Personal Information",
                style: TxtStyle.font18weigh700,
              ),
            ),

            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.03,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/images/profile.png",
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    AppTextFeild(
                      hintText: "Name",
                      textEditingController: nameController,
                    ),

                    SizedBox(height: screenHeight * 0.018),

                    AppTextFeild(
                      hintText: "Email",
                      textEditingController: emailController,
                    ),

                    SizedBox(height: screenHeight * 0.018),

                    AppTextFeild(
                      hintText: "Phone",
                      textEditingController: phoneController,
                    ),

                    SizedBox(height: screenHeight * 0.018),

                    AppTextFeild(
                      hintText: "Gender",
                      textEditingController: genderController,
                    ),

                    SizedBox(height: screenHeight * 0.018),

                    PassTxtFeild(
                      textEditingController: passwordController,
                      hintTxt: "New Password",
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    state is ProfileUpdateLoadingState
                        ? const CircularProgressIndicator()
                        : AppButton(
                      buttonTxt: "Save Changes",
                      function: () {
                        context
                            .read<ProfileCubit>()
                            .updateUserProfile(
                          name: nameController.text.trim(),
                          email:
                          emailController.text.trim(),
                          phone:
                          phoneController.text.trim(),
                          gender:
                          genderController.text.trim(),
                          password:
                          passwordController.text,
                        );
                      },
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