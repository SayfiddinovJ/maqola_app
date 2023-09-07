import 'package:cached_network_image/cached_network_image.dart';
import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/profile/profile_cubit.dart';
import 'package:columnist/cubits/profile/profile_state.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: SvgPicture.asset(AppIcons.smallLogo),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileErrorState) {
            Center(child: Text('ERROR ${state.error}'));
          }
          if (state is ProfileSuccessState) {
            UserModel user = state.userModel;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            user.email,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: baseUrl + user.avatar.substring(1),
                          height: 64.h,
                          width: 64.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.profession,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
