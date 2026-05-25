import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';

import 'package:doctor/features/auth/get_all_doctor/widgets/doctor_card.dart';
import 'package:doctor/features/auth/get_all_doctor/widgets/doctor_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  late GetAllDoctorCubit getAllDoctorCubit;

  @override
  void initState() {
    super.initState();
    getAllDoctorCubit = GetAllDoctorCubit();
    getAllDoctorCubit.getAllDoctors();
  }

  @override
  void dispose() {
    getAllDoctorCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllDoctorCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 18),

                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 16),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Search",
                      style: TxtStyle.font18weigh600.copyWith(fontSize: 17),
                    ),
                    const Spacer(),
                    const SizedBox(width: 34),
                  ],
                ),

                const SizedBox(height: 26),

                DoctorSearchBar(cubit: getAllDoctorCubit),

                const SizedBox(height: 24),

                BlocBuilder<GetAllDoctorCubit, GetAllDoctorState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 34,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          specialityChip(
                            title: "All",
                            selected:
                            getAllDoctorCubit.selectedSpecializationId == 0,
                            onTap: () {
                              getAllDoctorCubit
                                  .filterDoctorBySpecialization(0);
                            },
                          ),
                          ...getAllDoctorCubit.availableSpecializations.map(
                                (specialization) {
                              return specialityChip(
                                title: specialization.name ?? "",
                                selected: getAllDoctorCubit
                                    .selectedSpecializationId ==
                                    specialization.id,
                                onTap: () {
                                  getAllDoctorCubit
                                      .filterDoctorBySpecialization(
                                    specialization.id ?? 0,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: BlocBuilder<GetAllDoctorCubit, GetAllDoctorState>(
                    builder: (context, state) {
                      if (state is GetAllDoctorLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is GetAllDoctorErrorState) {
                        return Center(child: Text(state.errorMessage));
                      }

                      if (state is GetAllDoctorSuccessState) {
                        final doctors = state.doctorResponse.data;

                        if (doctors.isEmpty) {
                          return const Center(child: Text("No doctors found"));
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${doctors.length} founds",
                              style: TxtStyle.font18weigh600.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 90),
                                itemCount: doctors.length,
                                itemBuilder: (context, index) {
                                  return DoctorCard(
                                    doctor: doctors[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }

  Widget specialityChip({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? ColorManager.blue : const Color(0xffF4F6F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TxtStyle.font12weight400.copyWith(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return Stack(
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
                backgroundImage: AssetImage("assets/images/profile.png"),
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
    );
  }
}