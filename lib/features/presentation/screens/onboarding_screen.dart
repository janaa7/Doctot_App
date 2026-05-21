import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/login/presentation/login_screen.dart';
import 'package:doctor/features/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            top: h * 0.22,
            right: 0,
            child: Opacity(
              opacity: 0.04,
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
              opacity: 0.04,
              child: Image.asset(
                'assets/logo/Vector (1).png',
                width: w * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            top: h * 0.20,
            left: 0,
            right: 0,
            child: Center(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/logo/doctor.png',
                  height: h * 0.52,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/logo/frameee.png",
                    width: w * 0.45,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: h * 0.6,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "Best Doctor\nAppointment App",
                  textAlign: TextAlign.center,
                  style: TxtStyle.font32weight700,
                ),
                SizedBox(height: 14),

                Text(
                  "Manage and schedule all of your medical appointments easily \n                      with Docdoc to get a new experience.",
                  style: TxtStyle.font10weight400,
                ),
                SizedBox(height: 24),

                GestureDetector(
                  onTap: () => _finish(context),
                  child: Container(
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 52,
                    width: 311,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorManager.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}