import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/cubits/user/user_cubit.dart';
import 'package:columnist/data/models/user/user_fields.dart';
import 'package:columnist/ui/auth/checking/code/code_input_page.dart';
import 'package:columnist/ui/auth/global_text_field.dart';
import 'package:columnist/ui/auth/sign_in/sign_in_page.dart';
import 'package:columnist/ui/auth/sign_up/widget/gender_selector.dart';
import 'package:columnist/ui/auth/widgets/global_button.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/ui_utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ImagePicker imagePicker = ImagePicker();

  var contactFormatter = MaskTextInputFormatter(
    mask: '+998 (##) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
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
                        hintText: 'Username',
                        iconData: Icons.verified_user,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (v) => context
                            .read<UserCubit>()
                            .updateUserFields(
                                field: UserField.username, value: v),
                      ),
                      SizedBox(height: 20.h),
                      GlobalTextField(
                        hintText: 'Contact',
                        iconData: Icons.phone,
                        textInputType: TextInputType.phone,
                        textInputFormatter: contactFormatter,
                        onChanged: (v) {
                          if (v != '-' || v != '(' || v != ')' || v != '+') {
                            context.read<UserCubit>().updateUserFields(
                                field: UserField.contact, value: v);
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      GlobalTextField(
                        hintText: 'Email',
                        iconData: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (v) => context
                            .read<UserCubit>()
                            .updateUserFields(field: UserField.email, value: v),
                      ),
                      SizedBox(height: 20.h),
                      GlobalTextField(
                        hintText: 'Password',
                        iconData: Icons.key,
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (v) => context
                            .read<UserCubit>()
                            .updateUserFields(
                                field: UserField.password, value: v),
                      ),
                      SizedBox(height: 20.h),
                      GlobalTextField(
                        hintText: 'Profession',
                        iconData: Icons.work,
                        textInputType: TextInputType.text,
                        onChanged: (v) => context
                            .read<UserCubit>()
                            .updateUserFields(
                                field: UserField.profession, value: v),
                      ),
                      SizedBox(height: 20.h),
                      ListTile(
                        leading: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Select avatar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          showBottomSheetDialog();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                const GenderSelector(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlobalButton(
                      onPressed: () async {
                        if (context.read<UserCubit>().canRegister()) {
                          context.read<AuthCubit>().verifyViaGmail(
                                context.read<UserCubit>().state.userModel.email,
                                context
                                    .read<UserCubit>()
                                    .state
                                    .userModel
                                    .password,
                              );
                        }
                      },
                      text: 'Sign Up'),
                ),
                SizedBox(height: 50.h),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const SignInPage()),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            );
          },
          listener: (context, state) {
            if (state is AuthVerifySuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CodeInput(
                      user: context.read<UserCubit>().state.userModel),
                ),
              );
            }
            if (state is AuthErrorState) {
              showErrorMessage(message: state.error, context: context);
            }
          },
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: 180.h,
          decoration: BoxDecoration(
            color: AppColors.authBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context
          .read<UserCubit>()
          .updateUserFields(field: UserField.avatar, value: xFile.path);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context
          .read<UserCubit>()
          .updateUserFields(field: UserField.avatar, value: xFile.path);
    }
  }
}
