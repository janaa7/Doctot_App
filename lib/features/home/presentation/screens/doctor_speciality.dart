import 'package:doctor/features/home/logic/home_cubit.dart';
import 'package:doctor/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/txt_style.dart';

class DoctorSpeciality extends StatelessWidget {
  const DoctorSpeciality({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const SizedBox(
            height: 86,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeSuccessState) {
          return SizedBox(
            height: 86,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.homeData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo/general_icon.png",
                        height: 52,
                        width: 52,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.homeData[index].name ?? "",
                        style: TxtStyle.font12weight400,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return Text(
            state.errorMessage,
            style: TxtStyle.font12weight400,
          );
        } else {
          return const SizedBox(height: 86);
        }
      },
    );
  }
}