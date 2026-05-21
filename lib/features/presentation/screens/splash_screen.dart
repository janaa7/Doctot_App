import 'package:doctor/features/auth/get_all_doctor/presentation/get_all_doctor_screen.dart';
import 'package:doctor/features/auth/login/presentation/login_screen.dart';
import 'package:doctor/features/home/presentation/screens/home_screen.dart';
import 'package:doctor/features/presentation/screens/homePage_screen.dart';
import 'package:doctor/features/presentation/screens/onboarding_screen.dart';
import 'package:doctor/features/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen(),),
      );
    });
  }
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Stack(
        children: [





                Center(
                  child: Image.asset(
                    "assets/logo/frameee.png",
                    width: 268,
                    height: 72,
                    fit: BoxFit.contain,
                  ),
                ),




          Positioned(
            top: h * 0.22,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/logo/Vector.png',
                width: w * 0.8,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            bottom: h * 0.19,
            left: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/logo/Vector (1).png',
                width: w * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),


        ],
      ),
    );
  }
}