import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uisads_app/src/constants/import_constants.dart';

SnackBar showAlertCustom(String text, bool isError) {
  return SnackBar(
    content: Row(
      children: [
        Icon(
          isError ? CustomUisIcons.circle_error : CustomUisIcons.circle_ok,
          color: AppColors.mainThirdContrast,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: GoogleFonts.robotoSlab().fontFamily,
            fontWeight: FontWeight.w500, 
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: '\u2716',
      onPressed: () {},
      textColor: AppColors.mainThirdContrast,
    ),
    elevation: 1.0,
    backgroundColor: isError ? AppColors.reject : AppColors.accept,
    behavior: SnackBarBehavior.floating,
    duration: const Duration( seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  );
}
