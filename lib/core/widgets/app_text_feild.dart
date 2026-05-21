import 'package:doctor/core/utils/colors_manager.dart';
import 'package:doctor/core/utils/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextFeild extends StatelessWidget {
  bool? secureTxt;
  String hintText;
  Widget? suffixFeildIcon ;
  TextEditingController textEditingController;
  AppTextFeild({super.key,required this.hintText,required this.textEditingController, this.secureTxt,this.suffixFeildIcon});

bool showPass=false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secureTxt ?? false,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: suffixFeildIcon,

        hintText: hintText,
        hintStyle:TxtStyle.font14weight500 ,
        fillColor: ColorManager.txtFeildFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorManager.txtFeildBorderColor
          )
        )
      ),
    );
  }
}
