import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.07),
      alignment: Alignment.center,
      child: const Image(image: AssetImage('assets/images/logo_app_alt.png')),
    );
  }
}

// ignore: must_be_immutable
class TitleInfo extends StatelessWidget {
  String title;
  TitleInfo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.03,
        left: size.width * 0.03
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: AppColors.mainThirdContrast,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ignore: must_be_immutable
class DescriptionInfo extends StatelessWidget {
  String description;
  DescriptionInfo({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.01,
          left: size.width * 0.09,
          right: size.width * 0.02),
      child: Text(
        description,
        style: const TextStyle(
            color: AppColors.mainThirdContrast,
            fontSize: 12.0,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonRecovery extends StatelessWidget {
  String routeName;
  String text;
  String navigator;
  void Function() onPressed; 
  ButtonRecovery(
      {Key? key,
      required this.routeName,
      required this.text,
      required this.navigator,
      required this.onPressed
    }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            log('entrando al onPressed del boton');
            onPressed;
            switch (navigator) {
              case 'pop':
                Navigator.popAndPushNamed(context, routeName);
                break;
              case 'push':
                Navigator.pushNamed(context, routeName);
                break;
              case 'until':
                Navigator.pushNamedAndRemoveUntil(
                    context, routeName, (Route<dynamic> route) => false);
                break;
            }
            // isPop
            //     ? Navigator.popAndPushNamed(context, route)
            //     : Navigator.pushNamed(context, route);
          },
          child: Text(text),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }
}
