import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

InputDecoration decorationInputCustom(IconData icon, String hintText) {
  const double widthBorderInput = 1.5;
  const double borderRadiusInput = 10.0;
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput)
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 11.0, 
      color: AppColors.subtitles,      
    ),
    prefixIcon: Icon(icon, color: AppColors.subtitles),
    prefixIconColor: AppColors.primary,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput),
      borderSide: const BorderSide(
        color: AppColors.primary, width: widthBorderInput
      )
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput),
      borderSide: const BorderSide(
      color: AppColors.primary, width: widthBorderInput)
    )
  );
}
