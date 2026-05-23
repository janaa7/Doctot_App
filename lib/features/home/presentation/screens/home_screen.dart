import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/features/auth/get_all_doctor/presentation/get_all_doctor_screen.dart';
import 'package:doctor/features/home/logic/home_cubit.dart';
import 'package:doctor/features/home/presentation/screens/doctor_recommend.dart';
import 'package:doctor/features/home/presentation/screens/doctor_speciality.dart';
import 'package:doctor/features/home/presentation/screens/doctor_speciality_screen.dart';
import 'package:doctor/features/home/presentation/screens/nearby_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/txt_style.dart';

class HomeScreen extends StatelessWidget {
  String userName;

  HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.03,
                  vertical: screenHeight * 0.035,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi , $userName!",
                              style: TxtStyle.font18weigh700,
                            ),
                            Text(
                              "How are you today?",
                              style: TxtStyle.font12weight400,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: screenHeight * 0.032,
                          backgroundColor: Colors.grey.shade100,
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.black,
                            size: screenHeight * 0.033,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    const NearbyWidget(),

                    SizedBox(height: screenHeight * 0.02),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Doctor Speciality",
                          style: TxtStyle.font18weigh600,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<HomeCubit>(),
                                  child: const DoctorSpecialityScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: TxtStyle.font12weight400.copyWith(
                              color: ColorManager.blue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    const DoctorSpeciality(),

                    SizedBox(height: screenHeight * 0.035),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recommendation Doctor",
                          style: TxtStyle.font18weigh600,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const GetAllDoctorScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "See All",
                            style: TxtStyle.font12weight400.copyWith(
                              color: ColorManager.blue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    const RecommendationDoctor(),

                    SizedBox(height: screenHeight * 0.09),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 82,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.home_outlined, color: Colors.black),

                      Stack(
                        children: const [
                          Icon(Icons.chat_bubble_outline, color: Colors.black),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 65),

                      Icon(
                        Icons.calendar_month,
                        color: ColorManager.blue,
                      ),

                      const CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage("assets/images/profile.png"),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: -22,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: ColorManager.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}