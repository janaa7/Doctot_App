import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:doctor/features/appointments/presentation/summary_screen.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Doctor doctor;
  final String startTime;
  final String appointmentType;

  const PaymentScreen({
    super.key,
    required this.doctor,
    required this.startTime,
    required this.appointmentType,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "Credit Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),

              Row(
                children: [
                  backButton(),
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
              ),

              const SizedBox(height: 34),

              bookingSteps(),

              const SizedBox(height: 42),

              Text(
                "Payment Option",
                style: TxtStyle.font18weigh600.copyWith(fontSize: 15),
              ),

              const SizedBox(height: 20),

              paymentMainItem("Credit Card"),

              paymentSubItem(
                "assets/images/mastercard.png",
                "Master Card",
              ),
              paymentSubItem(
                "assets/images/americanexpress.png",
                "American Express",
              ),
              paymentSubItem(
                "assets/images/capital_one.png",
                "Capital One",
              ),
              paymentSubItem(
                "assets/images/barclays.png",
                "Barclays",
              ),

              const SizedBox(height: 16),

              paymentMainItem("Bank Transfer"),

              const SizedBox(height: 16),

              paymentMainItem("Paypal"),

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryScreen(
                          doctor: widget.doctor,
                          startTime: widget.startTime,
                          appointmentType: widget.appointmentType,
                          paymentMethod: selectedPayment,
                        ),
                      ),
                    );
                  },                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return InkWell(
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
    );
  }

  Widget bookingSteps() {
    return Row(
      children: [
        stepItem("1", "Date & Time", true, Colors.green),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 22),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        stepItem("2", "Payment", true, ColorManager.blue),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 22),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        stepItem("3", "Summary", false, Colors.grey.shade300),
      ],
    );
  }

  Widget stepItem(
      String number,
      String title,
      bool isActive,
      Color color,
      ) {
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
            color: isActive ? color : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget paymentMainItem(String title) {
    final bool isSelected = selectedPayment == title;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            size: 22,
            color: isSelected ? ColorManager.blue : Colors.grey.shade400,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TxtStyle.font12weight400black.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentSubItem(String image, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 34, top: 18),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                image,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.credit_card,
                    size: 24,
                    color: Colors.grey.shade500,
                  );
                },
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TxtStyle.font12weight400black.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ],
      ),
    );
  }
}