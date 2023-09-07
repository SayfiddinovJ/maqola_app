import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/ui/auth/global_text_field.dart';
import 'package:columnist/ui/auth/sign_up/sign_up_page.dart';
import 'package:columnist/ui/auth/widgets/global_button.dart';
import 'package:columnist/ui/tabs_box.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/ui_utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackgroundColor,
      body: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthLoggedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabsBox(),
                ),
              );
            }
            if (state is AuthErrorState) {
              showErrorMessage(message: state.error, context: context);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 69.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 26.w),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, eget erat bibendum in magna pretium rhoncus ut.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 33.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFieldBorderColor),
                    borderRadius: BorderRadius.circular(18.r),
                    color: AppColors.textFieldBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      GlobalTextField(
                        hintText: 'Email',
                        iconData: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (v) => email = v,
                      ),
                      SizedBox(height: 20.h),
                      GlobalTextField(
                        hintText: 'Password',
                        iconData: Icons.key,
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (v) => password = v,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlobalButton(
                      onPressed: () async {
                        if (email.isNotEmpty && password.isNotEmpty) {
                          context
                              .read<AuthCubit>()
                              .login(gmail: email, password: password);
                        }
                      },
                      text: 'Sign In'),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SignUpPage()),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
