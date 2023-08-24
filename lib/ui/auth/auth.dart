import 'package:columnist/ui/auth/sign_in/sign_in_page.dart';
import 'package:columnist/ui/tabs_box.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key,required this.isLogged});
  final bool isLogged;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogged ?  const TabsBox() : const SignInPage(),
    );
  }
}
