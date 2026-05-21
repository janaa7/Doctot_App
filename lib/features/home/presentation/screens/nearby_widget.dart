import 'package:flutter/material.dart';

import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/txt_style.dart';
class NearbyWidget extends StatelessWidget {
  const NearbyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: screenHeight * 0.25,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/find_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              "assets/images/miss_doctor.png",
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book and \nschedule with \nnearest doctor",
                  style: TxtStyle.font18weigh600,
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenHeight * 0.04),
                  ),
                  child: Center(
                    child: Text(
                      "Find Nearby",
                      style: TxtStyle.font12weight400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}