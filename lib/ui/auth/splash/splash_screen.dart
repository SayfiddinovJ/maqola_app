import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/cubits/profile/profile_cubit.dart';
import 'package:columnist/ui/auth/sign_in/sign_in_page.dart';
import 'package:columnist/ui/tabs_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit,AuthState>(
        builder: (context,state){
          return Center(
            child: FlutterLogo(size: 100.h),
          );
        },
        listener: (context,state){
          if(state is UnAuthenticatedState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
          }
          if(state is AuthLoggedState){
            BlocProvider.of<ProfileCubit>(context).getUser();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TabsBox()));
          }
        },
      ),
    );
  }
}
