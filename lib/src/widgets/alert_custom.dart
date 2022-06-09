import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

SnackBar showAlertCustom( String text, bool isError ) {
  return SnackBar(
    content: Text( text ),
    action: SnackBarAction(
      label: 'Cerrar',
      onPressed: () {},
      textColor: AppColors.mainThirdContrast,
    ),
    backgroundColor: isError ? AppColors.textile : AppColors.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24)
    ),
  );
}
