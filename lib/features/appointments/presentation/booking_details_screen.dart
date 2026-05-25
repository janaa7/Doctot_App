import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Doctor doctor;
  final String startTime;
  final String appointmentType;

  const BookingDetailsScreen({
    super.key,
    required this.doctor,
    required this.startTime,
    required this.appointmentType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 70),

            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                color: ColorManager.blue,
                size: 60,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Your Booking\nSuccessfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "You booked an appointment with ${doctor.name ?? ""}\non $startTime",
              textAlign: TextAlign.center,
              style: TxtStyle.font12weight400.copyWith(
                color: Colors.white.withOpacity(0.85),
                height: 1.6,
              ),
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                children: [
                  bookingRow("Doctor", doctor.name ?? ""),
                  bookingRow("Speciality", doctor.specialization?.name ?? ""),
                  bookingRow("Type", appointmentType),
                  bookingRow("Date & Time", startTime),
                  bookingRow("Price", "${doctor.appointPrice ?? 0} EGP"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                          (route) => route.isFirst,
                    );
                  },
                  child: const Text(
                    "Back To Home",
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget bookingRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Text(
            title,
            style: TxtStyle.font12weight400.copyWith(
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TxtStyle.font12weight400black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}