import 'package:doctor/features/home/data/homeDataModel.dart' as state;
import 'package:flutter/material.dart';
import 'package:doctor/features/home/logic/home_cubit.dart';
import 'package:doctor/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/txt_style.dart';

import '../../../../core/utils/txt_style.dart';

class RecommendationDoctor extends StatelessWidget {
  const RecommendationDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if(state is HomeLoadingState){


      return Center(child: CircularProgressIndicator(),);
    }
    else if(state is HomeSuccessState){
      return SizedBox(
        height: screenHeight * 0.3,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
          scrollDirection: Axis.vertical

          ,
          itemCount:state.homeData.length ,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: screenHeight *  0.01),
              child: Row(
                  spacing: 20,
                  children: [
                    Image.asset("assets/images/home_doctor.png"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 7,
                      children: [
                        Text(
                          state.homeData[index].doctors != null &&
                              state.homeData[index].doctors!.isNotEmpty
                              ? state.homeData[index].doctors!.first.name ?? "No name"
                              : "No doctor",
                          style: TxtStyle.font18weigh700,
                        ),                        Text(state.homeData[index].name!, style: TxtStyle.font12weight400),
                        Row(
                            spacing: 5,
                            children: [
                              Icon(Icons.star, color: Colors.yellow,),
                              Text("4.8", style: TxtStyle.font12weight400),
                              Text("(4,279 reviews)", style: TxtStyle.font12weight400),
                            ]
                        ),
                      ],
                    ),
                  ]
              ),
            );
          },
        ),
      );
    }
    else if(state is HomeErrorState){
      return Center(child: Text(state.errorMessage,style: TxtStyle.font32weight700,));
    }else{
      return SizedBox(height:12);
    }
  },
);
  }
}