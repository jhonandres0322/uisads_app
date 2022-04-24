import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';


Widget createLogo() {
  return const Image(
    image: AssetImage('assets/images/logo_app_alt.png')
  );
}


Widget createTitleInfo( Size size, String title) {
  return Padding(
    padding: EdgeInsets.only(
      top: size.height * 0.01
    ),
    child: Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(
          color: AppColors.mainThirdContrast,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget createTextInfo( Size size, String description) {
  return Padding(
    padding: EdgeInsets.only(
        top: size.height * 0.01,
        left: size.width * 0.085,
        right: size.height * 0.02),
    child: Text(
      description ,
      style: const TextStyle(
          color: AppColors.mainThirdContrast,
          fontSize: 14.0,
          fontWeight: FontWeight.normal),
    ),
  );
}

Widget createButton( BuildContext context, Size size, String route, String text, bool isPop) { 
  return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            isPop 
            ? Navigator.popAndPushNamed(context, route) 
            : Navigator.pushNamed(context, route);
          },
          child: Text( text ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
}
