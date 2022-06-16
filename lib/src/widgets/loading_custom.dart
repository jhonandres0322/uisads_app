import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class LoadingCircleCustom extends StatelessWidget {
  const LoadingCircleCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.primary,
    );
  }
}
