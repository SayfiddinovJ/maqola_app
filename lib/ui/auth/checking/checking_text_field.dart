import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckingTextField extends StatelessWidget {
  const CheckingTextField({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.textInputType,
  });

  final IconData iconData;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData,color: Colors.white,),
        labelText: hintText,
        hintText: hintText,
        labelStyle: TextStyle(
          fontSize : 14.sp,
          fontWeight : FontWeight.bold,
          color: AppColors.textColor,
        ),
        hintStyle: TextStyle(
          fontSize : 14.sp,
          fontWeight : FontWeight.w400,
          color: AppColors.textFieldBorderColor,
        ),
      ),
    );
  }
}
