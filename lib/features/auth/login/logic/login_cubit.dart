import 'package:dio/dio.dart';
import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/features/auth/login/data/login_model.dart';
import 'package:doctor/features/auth/login/logic/login_state.dart';
import 'package:doctor/helper/cash_helper.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../register/data/auth_response.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());


  Future login(LoginModel user) async {
    emit(LoginLoadingState());

    try {

      final response = await DioHelper.postData(
        url: APIConst.login,
        data: user.toJson(),
      );

      print("LOGIN RESPONSE:");
      print(response.data);

      if (response.statusCode == 200) {

        final auth = AuthResponse.fromJson(response.data);

        await CacheHelper.saveToken(auth.data!.token!);

        emit(
          LoginSuccessState(
            token: auth.data!.token!,
            userName: auth.data!.username!,
          ),
        );
      }

    } catch (e) {
      if (e is DioException) {
        print("LOGIN ERROR STATUS:");
        print(e.response?.statusCode);

        print("LOGIN ERROR DATA:");
        print(e.response?.data);
      } else {
        print(e.toString());
      }

      emit(
        LoginErrorState(
          errorMessage: e.toString(),
        ),
      );
    }}}