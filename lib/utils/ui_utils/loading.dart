import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      backgroundColor: AppColors.FF171717,
      child: Container(
        alignment: AlignmentDirectional.center,
        child: SizedBox(
          height: 70.h,
          width: 70.h,
          child: CircularProgressIndicator(
            strokeWidth: 6.w,
          ),
        ),
      ),
    ),
  );
}

void hideLoading({required BuildContext? loadingContext}) {
  if (loadingContext != null) Navigator.pop(loadingContext);
}
