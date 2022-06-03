import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';


class ButtonArrowBack extends StatelessWidget {
  final Color color;
  const ButtonArrowBack({ 
    Key? key,
    this.color =AppColors.mainThirdContrast,
   }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
        padding:
            EdgeInsets.only(top: size.height * 0.05, left: size.width * 0.02),
        child: IconButton(
              color: color,
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
        )
    );
  }
}