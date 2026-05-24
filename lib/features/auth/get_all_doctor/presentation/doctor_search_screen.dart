import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:doctor/features/auth/get_all_doctor/presentation/doctor_details_screen.dart';
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

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F6F9),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            getAllDoctorCubit.searchDoctors(value);
                          },
                          decoration: const InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(Icons.tune, size: 22),
                  ],
                ),

                const SizedBox(height: 24),

                BlocBuilder<GetAllDoctorCubit, GetAllDoctorState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 34,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          categoryItem(
                            context: context,
                            title: "All",
                            id: 0,
                            selected: getAllDoctorCubit.selectedSpecializationId == 0,
                          ),
                          ...getAllDoctorCubit.availableSpecializations.map(
                                (specialization) {
                              return categoryItem(
                                context: context,
                                title: specialization.name ?? "",
                                id: specialization.id ?? 0,
                                selected: getAllDoctorCubit.selectedSpecializationId ==
                                    specialization.id,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 22),

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
                                itemCount: doctors.length,
                                itemBuilder: (context, index) {
                                  final doctor = doctors[index];

                                  return doctorCard(context, doctor);
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
      ),
    );
  }

  Widget categoryItem({
    required BuildContext context,
    required String title,
    required int id,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        getAllDoctorCubit.filterDoctorBySpecialization(id);
      },
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

  Widget doctorCard(BuildContext context, Doctor doctor) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(
              doctorId: doctor.id ?? 0,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: doctor.photo != null && doctor.photo!.isNotEmpty
                  ? Image.network(
                doctor.photo!,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/home_doctor.png",
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                "assets/images/home_doctor.png",
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name ?? "",
                    style: TxtStyle.font18weigh600.copyWith(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${doctor.specialization?.name ?? ""} | ${doctor.city?.name ?? ""}",
                    style: TxtStyle.font12weight400.copyWith(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 17,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "4.8",
                        style: TxtStyle.font12weight400.copyWith(fontSize: 11),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(4,279 reviews)",
                        style: TxtStyle.font12weight400.copyWith(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}