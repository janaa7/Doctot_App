import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:doctor/features/auth/get_all_doctor/widgets/doctor_card.dart';
import 'package:doctor/features/auth/get_all_doctor/widgets/doctor_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllDoctorScreen extends StatefulWidget {
  const GetAllDoctorScreen({super.key});

  @override
  State<GetAllDoctorScreen> createState() =>
      _GetAllDoctorScreenState();
}

class _GetAllDoctorScreenState
    extends State<GetAllDoctorScreen> {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
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

              DoctorSearchBar(
                cubit: getAllDoctorCubit,
              ),

              const SizedBox(height: 12),

              Expanded(
                child: BlocBuilder<
                    GetAllDoctorCubit,
                    GetAllDoctorState>(
                  builder: (context, state) {
                    if (state is GetAllDoctorLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is GetAllDoctorSuccessState) {
                      final doctors =
                          state.doctorResponse.data;

                      if (doctors.isEmpty) {
                        return const Center(
                          child: Text("No doctors found"),
                        );
                      }

                      return ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          return DoctorCard(
                            doctor: doctors[index],
                          );
                        },
                      );
                    }

                    if (state is GetAllDoctorErrorState) {
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