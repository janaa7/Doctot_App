import 'package:doctor/core/utils/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
      Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi , Omar",style: TxtStyle.font18weigh700,),

            Row(children: [

              Text("How Are you Today?",style: TxtStyle.font10weight400,),
              SizedBox(width: 205,),
              Image.asset("assets/logo/Notification.png")
            ],)



          ],
        ),
      ),
      
      
      
      
      
      
      
      
    )
      ;
  }
}
