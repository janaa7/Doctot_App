import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showSortBottomSheet(
    BuildContext context,
    GetAllDoctorCubit cubit,
    ) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28),
      ),
    ),
    builder: (_) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          child: BlocBuilder<GetAllDoctorCubit, GetAllDoctorState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Sort By",
                    style: TxtStyle.font18weigh600.copyWith(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Divider(color: Colors.grey.shade200),

                  const SizedBox(height: 18),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Speciality",
                      style: TxtStyle.font18weigh600.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        sortItem(
                          cubit: cubit,
                          title: "All",
                          id: 0,
                          selected: cubit.selectedSpecializationId == 0,
                        ),
                        ...cubit.availableSpecializations.map(
                              (specialization) {
                            return sortItem(
                              cubit: cubit,
                              title: specialization.name ?? "",
                              id: specialization.id ?? 0,
                              selected: cubit.selectedSpecializationId ==
                                  specialization.id,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rating",
                      style: TxtStyle.font18weigh600.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ratingItem(
                          cubit: cubit,
                          title: "All",
                          rating: 0,
                        ),
                        ratingItem(
                          cubit: cubit,
                          title: "5",
                          rating: 5,
                        ),
                        ratingItem(
                          cubit: cubit,
                          title: "4",
                          rating: 4,
                        ),
                        ratingItem(
                          cubit: cubit,
                          title: "3",
                          rating: 3,
                        ),
                        ratingItem(
                          cubit: cubit,
                          title: "2",
                          rating: 2,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

Widget sortItem({
  required GetAllDoctorCubit cubit,
  required String title,
  required int id,
  required bool selected,
}) {
  return InkWell(
    onTap: () {
      cubit.filterDoctorBySpecialization(id);
    },
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18),
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

Widget ratingItem({
  required GetAllDoctorCubit cubit,
  required String title,
  required int rating,
}) {
  final bool selected = cubit.selectedRating == rating;

  return InkWell(
    onTap: () {
      cubit.changeRating(rating);
    },
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? ColorManager.blue : const Color(0xffF4F6F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            size: 16,
            color: selected ? Colors.white : Colors.grey.shade400,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TxtStyle.font12weight400.copyWith(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}