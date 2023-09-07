import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Center(
          child: SvgPicture.asset(AppIcons.smallLogo),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
    );
  }
}
