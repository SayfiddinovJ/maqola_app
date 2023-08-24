import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.textInputType,
    this.textInputFormatter,
    required this.controller,
  });

  final IconData iconData;
  final String hintText;
  final TextInputType textInputType;
  final TextInputFormatter? textInputFormatter;
  final TextEditingController controller;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  var maskFormatter = MaskTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      inputFormatters: [
        widget.textInputFormatter == null
            ? maskFormatter
            : widget.textInputFormatter!
      ],
      keyboardType: widget.textInputType,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.iconData,
          color: Colors.white,
        ),
        labelText: widget.hintText,
        hintText: widget.hintText,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
        counterStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
