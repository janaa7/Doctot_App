import 'package:doctor/core/const/ai_const.dart';
import 'package:doctor/features/home/data/homeDataModel.dart';
import 'package:doctor/features/home/logic/home_state.dart';
import 'package:doctor/helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    try {
      final response = await DioHelper.getData(
        url: APIConst.home,
      );

      if (response.statusCode == 200) {
        final data = HomeDataModel.fromJson(response.data);
        emit(HomeSuccessState(homeData: data.data!));
      } else {
        emit(HomeErrorState(errorMessage: "Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}