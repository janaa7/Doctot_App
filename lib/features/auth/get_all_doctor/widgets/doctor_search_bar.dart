import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DoctorSearchBar extends StatelessWidget {
  final GetAllDoctorCubit cubit;

  const DoctorSearchBar({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                cubit.searchDoctors(value);
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
        InkWell(
          onTap: () {
            showSortBottomSheet(context, cubit);
          },
          child: Icon(
            Icons.tune,
            color: ColorManager.blue,
            size: 22,
          ),
        ),
      ],
    );
  }
}