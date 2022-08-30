import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uisads_app/src/constants/colors.dart';

/// Widget Personalizado para el AlertDialog usado en la aplicacion de UISADS
class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final Color? titleColor;
  final String? positiveBtnText;
  final Color? positiveBtnColor;
  final String? negativeBtnText;
  final Color? negativeBtnColor;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;
  final IconData? icon;
  final Color? iconColor;

  CustomAlertDialog({
    required this.title,
    this.titleColor = Colors.black,
    this.circularBorderRadius = 5.0,
    this.bgColor = Colors.white,
    this.positiveBtnText = 'Aceptar',
    this.negativeBtnText = 'Cancelar',
    this.onPostivePressed,
    this.onNegativePressed, 
    this.icon, 
    this.iconColor, 
    this.positiveBtnColor = Colors.blue, 
    this.negativeBtnColor = Colors.white
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius)
      ),
      backgroundColor: bgColor,
      title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              fontWeight: FontWeight.w600,
              color: titleColor),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        negativeBtnText != null
            ? ElevatedButton(
                child: Text(negativeBtnText!),
                onPressed: () {
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.mainThirdContrast,
                    side: BorderSide(color: AppColors.subtitles),
                    onPrimary: AppColors.subtitles,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    textStyle: TextStyle(fontWeight: FontWeight.w400)),
              )
            : Container(),
        positiveBtnText != null
            ? ElevatedButton(
                child: Text(positiveBtnText!),
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed!();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.reject,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                        // fontSize: 30,
                        fontWeight: FontWeight.bold)),
              )
            : Container(),
      ],
      content: 
      icon != null
        ? Icon(
            icon,
            color: iconColor,
            size: size.height * 0.08,
          )
        : Container(),
    );
  }
}