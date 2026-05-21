import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllDoctorScreen extends StatelessWidget {
  const GetAllDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAllDoctorCubit()..getAllDoctors(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(width: 20),
                  Text(
                    "Recommendation Doctor",
                    style: TxtStyle.font18weigh600,
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz_sharp),
                ],
              ),
              const SizedBox(height: 12),
              Image.asset("assets/logo/Search Bar.png"),
              const SizedBox(height: 12),


              Expanded(
                child: BlocBuilder<GetAllDoctorCubit, DoctorStates>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is SuccessState) {
                      return ListView.builder(
                        itemCount: state.doctorResponse.data.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctorResponse.data[index];

                          return  Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: doctor.photo != null && doctor.photo!.isNotEmpty
                                      ? Image.network(
                                    doctor.photo!,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/home_doctor.png",
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                      : Image.asset(
                                    "assets/images/home_doctor.png",
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        doctor.name ?? "",
                                        style: TxtStyle.font18weigh600.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),

                                      Text(
                                        "${doctor.specialization?.name ?? ""} | ${doctor.city?.name ?? ""}",
                                        style: TxtStyle.font12weight400.copyWith(
                                          fontSize: 11,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "4.8",
                                            style: TxtStyle.font12weight400.copyWith(
                                              fontSize: 11,
                                              color: Colors.black87,
                                            ),
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
                          );
                        },
                      );
                    }

                    if (state is ErrorState) {
                      return Center(
                        child: Text(state.errorMessage),
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
    );
  }
}