import 'package:dio/dio.dart';
import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/features/auth/register/data/auth_response.dart';
import 'package:doctor/features/auth/register/data/user_model.dart';
import 'package:doctor/features/auth/register/logic/register_state.dart';
import 'package:doctor/helper/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit <RegisterState>{
RegisterCubit():
    super(RegisterInitialState());
Dio dio = Dio();
Future register ( UserModel user) async {
  emit(RegisterLoadingState());
  try{
   final response= await dio.post(APIConst.register,data:user.toJson());
if(response.statusCode==200){
  final auth=AuthResponse.fromJson(response.data);
   await CacheHelper.saveToken(auth.data!.token!);
  emit(RegisterSuccessState(token:auth.data!.token!,
  userName: auth.data!.username!));
}
  }
  catch(e){
    print("============register error $e");
    emit(RegisterErrorState(errorMessage: e.toString()));
  }
}

}