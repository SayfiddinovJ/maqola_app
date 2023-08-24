import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/ui/auth/global_text_field.dart';
import 'package:columnist/ui/auth/widgets/global_button.dart';
import 'package:columnist/ui/tabs_box.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/ui_utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({super.key, required this.user});

  final UserModel user;

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  TextEditingController confirmController = TextEditingController();

  var codeFormatter = MaskTextInputFormatter(
    mask: '### ###',
    filter: {"#": RegExp(r'[0-9]')},
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Text(
                'Verify Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 100.h),

              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textFieldBorderColor),
                  borderRadius: BorderRadius.circular(18.r),
                  color: AppColors.textFieldBackgroundColor,
                ),
                child: GlobalTextField(
                  controller: confirmController,
                  hintText: 'Code',
                  iconData: Icons.key,
                  textInputType: TextInputType.number,
                  textInputFormatter: codeFormatter,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GlobalButton(
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .checkTheIncomingCode(confirmController.text.replaceAll(' ', ''));
                  },
                  text: 'Confirm',
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthCheckTheCodeState) {
            context.read<AuthCubit>().registerUser(widget.user);
          }

          if (state is AuthVerifySuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const TabsBox()));
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.error, context: context);
          }
        },
      ),
    );
  }
}
