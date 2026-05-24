import '../data/get_all_doctor_model.dart';

class GetAllDoctorState {}

class GetAllDoctorInitialState extends GetAllDoctorState {}

class GetAllDoctorLoadingState extends GetAllDoctorState {}

class GetAllDoctorSuccessState extends GetAllDoctorState {
  final DoctorResponse doctorResponse;

  GetAllDoctorSuccessState({required this.doctorResponse});
}

class GetAllDoctorErrorState extends GetAllDoctorState {
  final String errorMessage;

  GetAllDoctorErrorState({required this.errorMessage});
}