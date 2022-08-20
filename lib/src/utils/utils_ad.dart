import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

import '../constants/import_constants.dart';



class AppBarAd extends StatelessWidget with PreferredSizeWidget {
  const AppBarAd({
    Key? key, 
    required this.title, 
    required this.text, 
    required this.onPressed
  }) : super(key: key);
  final String title;
  final String text;
  final Function onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: AppColors.mainThirdContrast,
      elevation: 10.0,
      title: Text( title, style: const TextStyle(color: AppColors.subtitles) ),
      actions: [
        ButtonCustom(
          colorBorder: AppColors.primary,
          colorButton: AppColors.primary,
          colorText: Colors.white,
          height: size.height * 0.05,
          width: size.width * 0.25,
          onPressed: onPressed,
          text: text,
          borderRadius: 20.0,
          marginHorizontal: size.width * 0.018,
          marginVertical: size.height * 0.013,
        )
      ]
    );
  }
}