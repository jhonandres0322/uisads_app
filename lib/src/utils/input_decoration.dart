import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';

// Clase para definir la decoracion de un input
InputDecoration decorationInputCustom(IconData icon, String hintText, [Color? iconColor = AppColors.subtitles, bool iconButton  = false]) {
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
    prefixIcon: (iconButton) ? IconButton(onPressed: (){}, icon: Icon(icon, color: iconColor)) : Icon(icon, color: iconColor),
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
/// Clase para definir la decoracion de un DropdownButtonFormField
InputDecoration decorationDropdownCustom(String hintText, [Color? iconColor = AppColors.subtitles, bool iconButton  = false]) {
  const double widthBorderInput = 1.5;
  const double borderRadiusInput = 10.0;
  
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput)
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 11.0, 
      color: AppColors.subtitles
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput),
      borderSide: const BorderSide(
        color: AppColors.subtitles, width: widthBorderInput
      )
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadiusInput),
      borderSide: const BorderSide(
      color: AppColors.subtitles, width: widthBorderInput)
    )
  );
}