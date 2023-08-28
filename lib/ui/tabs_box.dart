import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/cubits/tab/tab_cubit.dart';
import 'package:columnist/ui/auth/sign_in/sign_in_page.dart';
import 'package:columnist/ui/tabs/favorites/favorites_screen.dart';
import 'package:columnist/ui/tabs/home/home_screen.dart';
import 'package:columnist/ui/tabs/profile/profile_screen.dart';
import 'package:columnist/ui/tabs/sites/sites_screen.dart';
import 'package:columnist/ui/tabs/write/write_screen.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsBox extends StatefulWidget {
  const TabsBox({super.key});

  @override
  State<TabsBox> createState() => _TabsBoxState();
}

class _TabsBoxState extends State<TabsBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      const HomeScreen(),
      const SitesScreen(),
      const WriteScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocListener<AuthCubit, AuthState>(
        child: IndexedStack(
          index: context.watch<TabCubit>().state,
          children: screens,
        ),
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
          }
        },
      ),
      bottomNavigationBar: Container(
        color: AppColors.FF101010,
        child: BottomNavigationBar(
          elevation: 20,
          selectedItemColor: AppColors.FFF3F4F6,
          unselectedItemColor: AppColors.FF4D4D4D,
          backgroundColor: AppColors.FF101010,
          items:  [
            BottomNavigationBarItem(icon: const Icon(Icons.home_filled), label: "",backgroundColor: AppColors.FF101010),
            BottomNavigationBarItem(icon: const Icon(Icons.web), label: "",backgroundColor: AppColors.FF101010),
            BottomNavigationBarItem(icon: const Icon(Icons.edit), label: "",backgroundColor: AppColors.FF101010),
            BottomNavigationBarItem(icon: const Icon(Icons.favorite_border), label: "",backgroundColor: AppColors.FF101010),
            BottomNavigationBarItem(icon: const Icon(Icons.person_2_rounded), label: "",backgroundColor: AppColors.FF101010),
          ],
          currentIndex: context.watch<TabCubit>().state,
          onTap: context.read<TabCubit>().changeTabIndex
        ),
      ),
    );
  }
}
