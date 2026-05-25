import '../data/appointment_model.dart';

class AppointmentState {}

class AppointmentInitialState extends AppointmentState {}

class AppointmentLoadingState extends AppointmentState {}

class AppointmentSuccessState extends AppointmentState {
  final AppointmentResponse appointmentResponse;

  AppointmentSuccessState({required this.appointmentResponse});
}

class AppointmentErrorState extends AppointmentState {
  final String errorMessage;

  AppointmentErrorState({required this.errorMessage});
}
class AppointmentStoreLoadingState extends AppointmentState {}

class AppointmentStoreSuccessState extends AppointmentState {
  final String message;

  AppointmentStoreSuccessState({required this.message});
}

class AppointmentStoreErrorState extends AppointmentState {
  final String errorMessage;

  AppointmentStoreErrorState({required this.errorMessage});
}