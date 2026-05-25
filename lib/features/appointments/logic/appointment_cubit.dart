import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/appointment_model.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitialState());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  AppointmentResponse? appointmentResponse;

  Future<void> getAppointments() async {
    emit(AppointmentLoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.appointments,
      );

      appointmentResponse = AppointmentResponse.fromJson(response.data);

      emit(
        AppointmentSuccessState(
          appointmentResponse: appointmentResponse!,
        ),
      );
    } catch (error) {
      emit(
        AppointmentErrorState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> storeAppointment({
    required int doctorId,
    required String startTime,
  }) async {
    emit(AppointmentStoreLoadingState());

    try {
      final response = await DioHelper.postData(
        url: APIConst.storeAppointment,
        data: {
          "doctor_id": doctorId,
          "start_time": startTime,
        },
      );

      emit(
        AppointmentStoreSuccessState(
          message: response.data['message'] ?? "Appointment booked",
        ),
      );
    } catch (error) {
      emit(
        AppointmentStoreErrorState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}