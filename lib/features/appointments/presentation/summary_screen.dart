import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/appointments/logic/appointment_cubit.dart';
import 'package:doctor/features/appointments/logic/appointment_state.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment_success_screen.dart';

class SummaryScreen extends StatelessWidget {
  final Doctor doctor;
  final String startTime;
  final String appointmentType;
  final String paymentMethod;

  const SummaryScreen({
    super.key,
    required this.doctor,
    required this.startTime,
    required this.appointmentType,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(),
      child: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentStoreSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentSuccessScreen(
                  doctor: doctor,
                  startTime: startTime,
                  appointmentType: appointmentType,
                ),
              ),
            );
          }

          if (state is AppointmentStoreErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = AppointmentCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    header(context),
                    const SizedBox(height: 28),
                    bookingSteps(),
                    const SizedBox(height: 24),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Booking Information",
                              style: TxtStyle.font18weigh600.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 18),

                            infoItem(
                              Icons.calendar_month_outlined,
                              "Date & Time",
                              startTime,
                              ColorManager.blue,
                            ),

                            Divider(
                              height: 30,
                              color: Colors.grey.shade200,
                            ),

                            infoItem(
                              Icons.person_outline,
                              "Appointment Type",
                              appointmentType,
                              Colors.green,
                            ),

                            Divider(
                              height: 30,
                              color: Colors.grey.shade200,
                            ),

                            Text(
                              "Doctor Information",
                              style: TxtStyle.font18weigh600.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 16),

                            doctorCard(),

                            const SizedBox(height: 28),

                            Text(
                              "Payment Information",
                              style: TxtStyle.font18weigh600.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 16),

                            paymentCard(),

                            const SizedBox(height: 24),

                            paymentInfo(),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

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
                        onPressed: state is AppointmentStoreLoadingState
                            ? null
                            : () {
                          cubit.storeAppointment(
                            doctorId: doctor.id!,
                            startTime: startTime,
                          );
                        },
                        child: state is AppointmentStoreLoadingState
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          "Book Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
        ),
        const Spacer(),
        Text(
          "Book Appointment",
          style: TxtStyle.font16weight600.copyWith(
            color: Colors.black,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 42),
      ],
    );
  }

  Widget bookingSteps() {
    return Row(
      children: [
        stepItem("1", "Date & Time", Colors.green),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 22),
            height: 1,
            color: Colors.green,
          ),
        ),
        stepItem("2", "Payment", Colors.green),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 22),
            height: 1,
            color: Colors.green,
          ),
        ),
        stepItem("3", "Summary", ColorManager.blue),
      ],
    );
  }

  Widget stepItem(String number, String title, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TxtStyle.font12weight400.copyWith(
            color: color,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget infoItem(
      IconData icon,
      String title,
      String subtitle,
      Color color,
      ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TxtStyle.font12weight400black.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TxtStyle.font12weight400.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget doctorCard() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: doctor.photo != null && doctor.photo!.isNotEmpty
              ? Image.network(
            doctor.photo!,
            width: 62,
            height: 62,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/home_doctor.png",
                width: 62,
                height: 62,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            "assets/images/home_doctor.png",
            width: 62,
            height: 62,
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
                style: TxtStyle.font16weight600.copyWith(
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                "${doctor.specialization?.name ?? ""} | ${doctor.city?.name ?? ""}",
                style: TxtStyle.font12weight400.copyWith(
                  color: Colors.grey,
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
                    size: 15,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "4.8 (4,279 reviews)",
                    style: TxtStyle.font12weight400.copyWith(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.paypal,
            color: Colors.blue,
            size: 34,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentMethod,
                  style: TxtStyle.font12weight400black.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "**** **** **** 37842",
                  style: TxtStyle.font12weight400.copyWith(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: ColorManager.blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Change",
              style: TxtStyle.font12weight400.copyWith(
                color: ColorManager.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentInfo() {
    final int price = doctor.appointPrice ?? 0;
    final int tax = 50;
    final int total = price + tax;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          paymentRow("Subtotal", "$price EGP"),
          const SizedBox(height: 14),
          paymentRow("Tax", "$tax EGP"),
          const SizedBox(height: 18),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 14),
          paymentRow(
            "Payment Total",
            "$total EGP",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget paymentRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TxtStyle.font12weight400.copyWith(
            color: isBold ? Colors.black : Colors.grey,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TxtStyle.font12weight400black.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}