import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';

class DoctorDetailsStates {}

class DoctorDetailsInitialState extends DoctorDetailsStates {}

class DoctorDetailsLoadingState extends DoctorDetailsStates {}

class DoctorDetailsSuccessState extends DoctorDetailsStates {
  final Doctor doctor;

  DoctorDetailsSuccessState({required this.doctor});
}

class DoctorDetailsErrorState extends DoctorDetailsStates {
  final String errorMessage;

  DoctorDetailsErrorState({required this.errorMessage});
}