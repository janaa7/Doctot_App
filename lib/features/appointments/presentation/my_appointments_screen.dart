import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/appointments/presentation/payment_screen.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const BookAppointmentScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<BookAppointmentScreen> createState() =>
      _BookAppointmentScreenState();
}

class _BookAppointmentScreenState
    extends State<BookAppointmentScreen> {

  int selectedDayIndex = 2;
  int selectedTimeIndex = 1;

  final List<String> days = [
    "Mon\n06",
    "Tue\n07",
    "Wed\n08",
    "Thu\n09",
    "Fri\n10",
  ];

  final List<String> times = [
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "11:00 AM",
  ];

  final List<String> appointmentTypes = [
    "In Person",
    "Video Call",
    "Phone Call",
  ];

  int selectedAppointmentType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text(
          "Book Appointment",
          style: TxtStyle.font16weight600.copyWith(
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 14),

            bookingSteps(),

            const SizedBox(height: 34),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date",
                  style: TxtStyle.font18weigh600.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Set Manual",
                  style: TxtStyle.font12weight400.copyWith(
                    color: ColorManager.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected =
                      selectedDayIndex == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      width: 62,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.blue
                            : Colors.grey.shade100,
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          days[index],
                          textAlign: TextAlign.center,
                          style: TxtStyle.font12weight400.copyWith(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) =>
                const SizedBox(width: 10),
                itemCount: days.length,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Available time",
              style: TxtStyle.font18weigh600.copyWith(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 18),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: times.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 54,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {

                final isSelected =
                    selectedTimeIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTimeIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.blue
                          : Colors.grey.shade100,
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        times[index],
                        style: TxtStyle.font12weight400.copyWith(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Text(
              "Appointment Type",
              style: TxtStyle.font18weigh600.copyWith(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {

                  final isSelected =
                      selectedAppointmentType == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedAppointmentType = index;
                      });
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? ColorManager.blue
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [

                          CircleAvatar(
                            radius: 18,
                            backgroundColor:
                            ColorManager.blue.withOpacity(0.1),
                            child: Icon(
                              index == 0
                                  ? Icons.people_outline
                                  : index == 1
                                  ? Icons.videocam_outlined
                                  : Icons.call_outlined,
                              color: ColorManager.blue,
                              size: 18,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              appointmentTypes[index],
                              style:
                              TxtStyle.font12weight400black,
                            ),
                          ),

                          CircleAvatar(
                            radius: 10,
                            backgroundColor: isSelected
                                ? ColorManager.blue
                                : Colors.transparent,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? ColorManager.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) =>
                const SizedBox(height: 14),
                itemCount: appointmentTypes.length,
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        doctor: widget.doctor,
                        startTime: "2026-10-10 14:00",
                        appointmentType:
                        appointmentTypes[selectedAppointmentType],
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
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

  Widget bookingSteps() {
    return Row(
      children: [

        stepItem(
          number: "1",
          title: "Date & Time",
          isActive: true,
        ),

        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),

        stepItem(
          number: "2",
          title: "Payment",
          isActive: false,
        ),

        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),

        stepItem(
          number: "3",
          title: "Summary",
          isActive: false,
        ),
      ],
    );
  }

  Widget stepItem({
    required String number,
    required String title,
    required bool isActive,
  }) {
    return Column(
      children: [

        CircleAvatar(
          radius: 16,
          backgroundColor: isActive
              ? ColorManager.blue
              : Colors.grey.shade300,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: TxtStyle.font12weight400.copyWith(
            color: isActive
                ? ColorManager.blue
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}