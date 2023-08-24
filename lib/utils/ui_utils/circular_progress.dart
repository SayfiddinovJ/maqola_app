import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key, this.strokeWidth});

  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    if (strokeWidth == 4 || strokeWidth == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    } else {
      return CircularProgressIndicator(strokeWidth: strokeWidth!);
    }
  }
}
