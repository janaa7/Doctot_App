import 'package:doctor/features/home/data/homeDataModel.dart';
import 'package:doctor/features/home/logic/home_cubit.dart';

class HomeState{}

class HomeInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}

class HomeSuccessState extends HomeState{
  List<Data> homeData;
  HomeSuccessState({required this.homeData});

}

class HomeErrorState extends HomeState{

  String errorMessage;
  HomeErrorState({required this.errorMessage});
}


