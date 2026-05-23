import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/home/logic/home_cubit.dart';
import 'package:doctor/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  const DoctorSpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),

        child: Column(
          children: [

            /// HEADER
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
                  "Doctor Speciality",
                  style: TxtStyle.font18weigh600,
                ),

                const Spacer(),

                const Icon(Icons.more_horiz_sharp),
              ],
            ),

            const SizedBox(height: 25),

            /// SPECIALITIES
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {

                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is HomeSuccessState) {

                    return GridView.builder(
                      itemCount: state.homeData.length,

                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 25,
                        childAspectRatio: 0.8,
                      ),

                      itemBuilder: (context, index) {

                        return Column(
                          children: [

                            CircleAvatar(
                              radius: 35,
                              backgroundColor: const Color(0xffF5F8FF),

                              child: Image.asset(
                                "assets/logo/general_icon.png",
                                width: 35,
                                height: 35,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              state.homeData[index].name ?? "",
                              style: TxtStyle.font12weight400,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    );
                  }

                  if (state is HomeErrorState) {
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
    );
  }
}