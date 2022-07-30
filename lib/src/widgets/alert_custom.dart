import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

SnackBar showAlertCustom(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      style: const TextStyle(fontSize: 11.0),
    ),
    action: SnackBarAction(
      label: 'Cerrar',
      onPressed: () {},
      textColor: AppColors.mainThirdContrast,
    ),
    elevation: 1.0,
    backgroundColor: isError ? AppColors.reject : AppColors.accept,
    behavior: SnackBarBehavior.floating,
    duration: const Duration( seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  );
}
