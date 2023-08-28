import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/profile/profile_cubit.dart';
import 'package:columnist/cubits/profile/profile_state.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileSuccessState) {
            return Column(
              children: [
                Text(
                  state.userModel.username,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          }
          return Center(child: Text(state.toString()));
        },
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            Column(
              children: [
                Text(state.userModel.username),
              ],
            );
          }
          if (state is ProfileErrorState) {
            Column(
              children: [
                Text('ERROR ${state.error}'),
              ],
            );
          }
        },
      ),
    );
  }
}
