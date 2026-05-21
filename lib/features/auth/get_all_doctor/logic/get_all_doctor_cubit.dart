import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/features/auth/get_all_doctor/data/get_all_doctor_model.dart';
import 'package:doctor/features/auth/get_all_doctor/logic/get_all_doctor_state.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllDoctorCubit extends Cubit<DoctorStates> {
  GetAllDoctorCubit() : super(InitialState());

  Future<void> getAllDoctors() async {
    emit(LoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.doctor,
      );

      if (response.statusCode == 200) {
        final data = DoctorResponse.fromJson(response.data);
        emit(SuccessState(doctorResponse: data));
      } else {
        emit(ErrorState(errorMessage: "Status code: ${response.statusCode}"));
      }
    } catch (e) {
      print("=============Get Doctors error: $e");
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}