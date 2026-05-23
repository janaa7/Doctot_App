import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/doctor_details_state.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  DoctorDetailsCubit() : super(DoctorDetailsInitialState());

  Future<void> getDoctorDetails({required int doctorId}) async {
    emit(DoctorDetailsLoadingState());

    try {
      final response = await DioHelper.getData(
        url: "${APIConst.showDoctor}/$doctorId",
      );

      if (response.statusCode == 200) {
        final doctor = Doctor.fromJson(response.data["data"]);
        emit(DoctorDetailsSuccessState(doctor: doctor));
      } else {
        emit(
          DoctorDetailsErrorState(
            errorMessage: "Status code: ${response.statusCode}",
          ),
        );
      }
    } catch (e) {
      emit(DoctorDetailsErrorState(errorMessage: e.toString()));
    }
  }
}