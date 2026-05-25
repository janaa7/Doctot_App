import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/presentation/doctor_search_screen.dart';
import 'package:doctor/features/profile/logic/profile_cubit.dart';
import 'package:doctor/features/profile/logic/profile_state.dart';
import 'package:doctor/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:doctor/helper/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);

          final user = state is ProfileSuccessState
              ? state.profileResponse.data
              : cubit.profileResponse?.data;

          return Scaffold(
            backgroundColor: Colors.white,
            body: state is ProfileLoadingState
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: ColorManager.blue,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Profile",
                                style: TxtStyle.font16weight600,
                              ),
                              const Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -45),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, -55),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: const [
                                  CircleAvatar(
                                    radius: 64,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 56,
                                      backgroundColor:
                                      Colors.grey,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Transform.translate(
                              offset: const Offset(0, -40),
                              child: Column(
                                children: [
                                  Text(
                                    user?.name ?? ""      ,
                                    style: TxtStyle.font18weigh700,
                                  ),
                                  const SizedBox(height: 8),

                                  Text(
                                    user?.email ??
                                        "No email from API",
                                    style:
                                    TxtStyle.font14weight400,
                                  ),

                                  const SizedBox(height: 28),

                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color:
                                      Colors.grey.shade100,
                                      borderRadius:
                                      BorderRadius.circular(
                                          14),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "My Appointment",
                                              style: TxtStyle
                                                  .font12weight400black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 32,
                                          color: Colors
                                              .grey.shade300,
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Medical records",
                                              style: TxtStyle
                                                  .font12weight400black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 26),

                                  profileItem(
                                    icon:
                                    Icons.badge_outlined,
                                    title:
                                    "Personal Information",
                                    iconColor:
                                    ColorManager.blue,
                                    onTap: () {
                                      if (user != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                PersonalInformationScreen(
                                                  profileModel:
                                                  user,
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                  ),

                                  profileItem(
                                    icon: Icons
                                        .medical_services_outlined,
                                    title:
                                    "My Test & Diagnostic",
                                    iconColor: Colors.green,
                                    onTap: () {},
                                  ),

                                  profileItem(
                                    icon:
                                    Icons.payment_outlined,
                                    title: "Payment",
                                    iconColor:
                                    Colors.redAccent,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            bottomNavigationBar: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 82,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                      ),
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 65),
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -22,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const DoctorSearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget profileItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor:
                iconColor.withOpacity(0.12),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TxtStyle.font12weight400black
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}