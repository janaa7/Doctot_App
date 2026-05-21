
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';

class DoctorStates{}

class InitialState extends DoctorStates{}

class LoadingState extends DoctorStates{}

class SuccessState extends DoctorStates{
  final DoctorResponse doctorResponse;
  SuccessState({required this.doctorResponse});
}

class ErrorState extends DoctorStates{
  final String errorMessage;
  ErrorState ({required this.errorMessage});
}

