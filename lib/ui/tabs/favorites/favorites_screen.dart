import 'package:columnist/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Favorites'),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}
