import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/appointments/presentation/my_appointments_screen.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_cubit.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int doctorId;

  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAllDoctorCubit()..getDoctorDetails(widget.doctorId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<GetAllDoctorCubit, GetAllDoctorState>(
          builder: (context, state) {
            if (state is GetAllDoctorLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetAllDoctorErrorState) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is GetAllDoctorSuccessState) {
              final doctor = state.doctorResponse.data.first;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 16,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: Text(
                              doctor.name ?? "Doctor Details",
                              style: TxtStyle.font18weigh600.copyWith(
                                fontSize: 17,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.more_horiz, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      doctorHeader(doctor),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          tabItem("About", 0),
                          tabItem("Location", 1),
                          tabItem("Reviews", 2),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300, height: 1),
                      Expanded(
                        child: selectedIndex == 0
                            ? aboutTab(doctor)
                            : selectedIndex == 1
                            ? locationTab(doctor)
                            : reviewsTab(),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookAppointmentScreen(
                                  doctor: doctor,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Make An Appointment",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget doctorHeader(Doctor doctor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: doctor.photo != null && doctor.photo!.isNotEmpty
              ? Image.network(
            doctor.photo!,
            width: 74,
            height: 74,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/home_doctor.png",
                width: 74,
                height: 74,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            "assets/images/home_doctor.png",
            width: 74,
            height: 74,
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
                style: TxtStyle.font18weigh700.copyWith(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                "${doctor.specialization?.name ?? ""} | ${doctor.city?.name ?? ""}",
                style: TxtStyle.font12weight400.copyWith(
                  color: Colors.grey,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                doctor.degree ?? "",
                style: TxtStyle.font12weight400.copyWith(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.chat_bubble_outline,
          color: ColorManager.blue,
          size: 22,
        ),
      ],
    );
  }

  Widget tabItem(String title, int index) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TxtStyle.font12weight400.copyWith(
              color: isSelected ? ColorManager.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 2,
            width: 82,
            color: isSelected ? ColorManager.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget aboutTab(Doctor doctor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About me", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.description ?? "No description available",
            style: TxtStyle.font12weight400.copyWith(
              height: 1.7,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Text("Working Time", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            "${doctor.startTime ?? ""} - ${doctor.endTime ?? ""}",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text("Appointment Price", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            "${doctor.appointPrice ?? 0} EGP",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text("Phone", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.phone ?? "No Phone",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text("Email", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.email ?? "No Email",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget locationTab(Doctor doctor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Practice Place", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.address ?? "No Address",
            style: TxtStyle.font12weight400.copyWith(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text("City", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.city?.name ?? "No City",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text("Governrate", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 10),
          Text(
            doctor.city?.governrate?.name ?? "No Governrate",
            style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text("Location Map", style: TxtStyle.font18weigh600.copyWith(fontSize: 15)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/map.png",
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewsTab() {
    return Center(
      child: Text(
        "No reviews data from API",
        style: TxtStyle.font12weight400.copyWith(color: Colors.grey),
      ),
    );
  }
}