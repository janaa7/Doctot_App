import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppointmentSuccessScreen extends StatelessWidget {
  final Doctor doctor;
  final String startTime;
  final String appointmentType;

  const AppointmentSuccessScreen({
    super.key,
    required this.doctor,
    required this.startTime,
    required this.appointmentType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              header(context),
              const SizedBox(height: 48),
              Center(
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Lottie.asset(
                    "assets/images/successfully.json",
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Booking Confirmed",
                  style: TxtStyle.font18weigh600.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 52),
              Text(
                "Booking Information",
                style: TxtStyle.font18weigh600.copyWith(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 22),
              infoItem(
                icon: Icons.calendar_month_outlined,
                title: "Date & Time",
                subtitle: startTime,
                color: ColorManager.blue,
              ),
              Divider(
                height: 34,
                color: Colors.grey.shade200,
              ),
              infoItem(
                icon: Icons.assignment_outlined,
                title: "Appointment Type",
                subtitle: appointmentType,
                color: Colors.green,
                trailing: getLocationButton(),
              ),
              Divider(
                height: 34,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 8),
              Text(
                "Doctor Information",
                style: TxtStyle.font18weigh600.copyWith(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 22),
              doctorCard(),
              const Spacer(),
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
                    Navigator.popUntil(
                      context,
                          (route) => route.isFirst,
                    );
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
              const SizedBox(height: 24),
            ],
          ),
        ),
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
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 17,
            ),
          ),
        ),
        const Spacer(),
        Text(
          "Details",
          style: TxtStyle.font16weight600.copyWith(
            color: Colors.black,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 38),
      ],
    );
  }

  Widget infoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 21,
          backgroundColor: color.withOpacity(0.12),
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TxtStyle.font12weight400.copyWith(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget getLocationButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: ColorManager.blue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      child: Text(
        "Get Location",
        style: TxtStyle.font12weight400.copyWith(
          color: ColorManager.blue,
          fontSize: 11,
        ),
      ),
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
            width: 76,
            height: 76,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/home_doctor.png",
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            "assets/images/home_doctor.png",
            width: 76,
            height: 76,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
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
              const SizedBox(height: 7),
              Text(
                "${doctor.specialization?.name ?? ""} | ${doctor.city?.name ?? ""}",
                style: TxtStyle.font12weight400.copyWith(
                  color: Colors.grey,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
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
}