import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    required this.colorText,
    required this.colorButton,
    required this.colorBorder,
    this.borderRadius = 12.0,
    this.marginVertical = 0,
    this.marginHorizontal = 0
  }) : super(key: key);

  final double height;
  final double width;
  final Function onPressed;
  final String text;
  final Color colorText;
  final Color colorButton;
  final Color colorBorder;
  final double borderRadius;
  final double marginVertical;
  final double marginHorizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical, 
        horizontal: marginHorizontal
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        }, 
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto'
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular( borderRadius )
          ),
          side: BorderSide(
            width: 1.0,
            color: colorBorder
          )
        ),
      ),
    );
  }
}