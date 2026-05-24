import 'dart:async';

import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/helper/dio_helper.dart' show DioHelper;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/get_all_doctor_model.dart';
import 'get_all_doctor_state.dart';

class GetAllDoctorCubit extends Cubit<GetAllDoctorState> {
  GetAllDoctorCubit() : super(GetAllDoctorInitialState());

  static GetAllDoctorCubit get(context) => BlocProvider.of(context);

  DoctorResponse? originalDoctors;
  Timer? debounce;

  List<Specialization> availableSpecializations = [];
  int selectedSpecializationId = 0;

  Future<void> getAllDoctors() async {
    emit(GetAllDoctorLoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.doctor,
      );

      final doctorResponse = DoctorResponse.fromJson(response.data);

      originalDoctors = doctorResponse;
      extractSpecializations(doctorResponse.data);

      emit(GetAllDoctorSuccessState(doctorResponse: doctorResponse));
    } catch (error) {
      emit(GetAllDoctorErrorState(errorMessage: error.toString()));
    }
  }

  void extractSpecializations(List<Doctor> doctors) {
    final Map<int, Specialization> specializations = {};

    for (var doctor in doctors) {
      if (doctor.specialization != null &&
          doctor.specialization!.id != null) {
        specializations[doctor.specialization!.id!] =
        doctor.specialization!;
      }
    }

    availableSpecializations = specializations.values.toList();
  }

  Future<void> searchFromApi(String query) async {
    try {
      final response = await DioHelper.getData(
        url: APIConst.searchDoctor,
        query: {
          "name": query.trim(),
        },
      );

      print(response.realUri);
      print(response.data);

      final doctorResponse = DoctorResponse.fromJson(response.data);

      emit(GetAllDoctorSuccessState(doctorResponse: doctorResponse));
    } catch (error) {
      print(error);
      emit(GetAllDoctorErrorState(errorMessage: error.toString()));
    }
  }

  void searchDoctors(String query) {
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }

    debounce = Timer(const Duration(milliseconds: 250), () {
      selectedSpecializationId = 0;

      if (query.trim().isEmpty) {
        if (originalDoctors != null) {
          emit(GetAllDoctorSuccessState(doctorResponse: originalDoctors!));
        } else {
          getAllDoctors();
        }
      } else {
        searchFromApi(query);
      }
    });
  }

  Future<void> filterDoctorBySpecialization(int specializationId) async {
    selectedSpecializationId = specializationId;

    if (specializationId == 0) {
      if (originalDoctors != null) {
        emit(GetAllDoctorSuccessState(doctorResponse: originalDoctors!));
      } else {
        getAllDoctors();
      }
      return;
    }

    emit(GetAllDoctorLoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.filterDoctor,
        query: {
          "specialization": specializationId,
        },
      );

      final doctorResponse = DoctorResponse.fromJson(response.data);

      emit(GetAllDoctorSuccessState(doctorResponse: doctorResponse));
    } catch (error) {
      emit(GetAllDoctorErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> getDoctorDetails(int id) async {
    emit(GetAllDoctorLoadingState());

    try {
      final response = await DioHelper.getData(
        url: "${APIConst.showDoctor}/$id",
      );

      final doctor = Doctor.fromJson(response.data['data']);

      final doctorResponse = DoctorResponse(
        message: response.data['message'],
        data: [doctor],
        status: response.data['status'],
        code: response.data['code'],
      );

      emit(GetAllDoctorSuccessState(doctorResponse: doctorResponse));
    } catch (error) {
      emit(GetAllDoctorErrorState(errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() {
    debounce?.cancel();
    return super.close();
  }
}