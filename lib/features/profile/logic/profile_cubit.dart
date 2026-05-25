import 'package:dio/dio.dart';
import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileResponse? profileResponse;

  Future<void> getUserProfile() async {
    emit(ProfileLoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.userProfile,
      );

      print("PROFILE RESPONSE:");
      print(response.data);

      profileResponse = ProfileResponse.fromJson(response.data);

      emit(
        ProfileSuccessState(
          profileResponse: profileResponse!,
        ),
      );
    } catch (error) {
      emit(
        ProfileErrorState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    emit(ProfileUpdateLoadingState());

    try {
      String apiGender =
      gender.toLowerCase() == "female" ? "0" : "1";

      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        "gender": apiGender,
        if (password.trim().isNotEmpty)
          "password": password,
      });

      print("UPDATE PROFILE DATA:");
      print(formData.fields);

      final response = await DioHelper.postData(
        url: APIConst.updateProfile,
        data: formData,
      );

      print("UPDATE PROFILE RESPONSE:");
      print(response.data);

      emit(
        ProfileUpdateSuccessState(
          message:
          response.data['message'] ??
              "Profile updated successfully",
        ),
      );

      await getUserProfile();
    } catch (error) {
      if (error is DioException) {
        print("UPDATE PROFILE STATUS:");
        print(error.response?.statusCode);

        print("UPDATE PROFILE ERROR DATA:");
        print(error.response?.data);

        emit(
          ProfileErrorState(
            errorMessage: error.response?.data.toString() ?? error.toString(),
          ),
        );
      } else {
        emit(
          ProfileErrorState(
            errorMessage: error.toString(),
          ),
        );
      }}}}