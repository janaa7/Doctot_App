
import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/features/auth/get_all_doctor/presentation/get_all_doctor_screen.dart';
import 'package:doctor/features/home/logic/home_cubit.dart';
import 'package:doctor/features/home/presentation/screens/doctor_recommend.dart';
import 'package:doctor/features/home/presentation/screens/doctor_speciality.dart';
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
    double screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
  create: (context) => HomeCubit()..getHomeData(),
  child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: screenHeight * 0.03, vertical: screenHeight * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hi , $userName!", style: TxtStyle.font18weigh700),
                            Text("How are you today?", style: TxtStyle.font12weight400)
                          ]
                      ),
                      CircleAvatar(
                        radius: screenHeight * 0.032,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.notifications_outlined, color: Colors.black,size: screenHeight * 0.033,),
                      ),
                    ]
                ),
        
                NearbyWidget(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Doctor Speciality", style: TxtStyle.font18weigh600),
                      Text("See All", style: TxtStyle.font12weight400),
                    ]
                ),
                SizedBox(height: screenHeight * 0.02,),
                DoctorSpeciality(),
                SizedBox(height: screenHeight * 0.04,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recommendation Doctor", style: TxtStyle.font18weigh600),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetAllDoctorScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TxtStyle.font12weight400,
                        ),
                      ),                    ]
                ),
                SizedBox(height: screenHeight * 0.02,),
                RecommendationDoctor(),
              ]
          ),
        ),
      ),
    ),
);
  }
}