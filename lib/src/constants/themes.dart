import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uisads_app/src/constants/colors.dart';

class AppTheme {
  static ThemeData themePrimary = ThemeData(
    scaffoldBackgroundColor: AppColors.mainThirdContrast,
    textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: const AppBarTheme(
      color: AppColors.primary,
      elevation: 1,
      iconTheme: IconThemeData(
        color: AppColors.logoSchoolOpaque,
      )
    ),
    primaryColor: AppColors.primary
  );
}
