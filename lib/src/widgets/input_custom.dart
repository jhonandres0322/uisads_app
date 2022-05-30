import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

// ignore: must_be_immutable
class InputCustom extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData icon;

  String value = '';

  InputCustom(
      {Key? key,
      required this.hintText,
      this.labelText = '',
      this.obscureText = false,
      required this.keyboardType,
      required this.icon,
      required this.value})
      : super(key: key);

  final double widthBorderInput = 1.5;
  final double borderRadiusInput = 10.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.01),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: const TextStyle(
                  color: AppColors.subtitles,
                  fontSize: 14, 
                  fontWeight: FontWeight.w400, 
                  fontFamily: 'Roboto'
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          // ignore: sized_box_for_whitespace
          TextFormField(
            autofocus: false,
            obscureText: obscureText,
            keyboardType: keyboardType,
            initialValue: '',
            onChanged: (value) {
              this.value = value;
              log("onchange value --> $value");
            },
            validator: (value) {
              if (value == null) return "Este campo es requerido";
              return value.length < 3 ? 'Minimo de 3 letras' : null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadiusInput)),
                prefixIcon: Icon(icon, color: AppColors.subtitles),
                prefixIconColor: AppColors.primary,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusInput),
                    borderSide: BorderSide(
                        color: AppColors.primary, width: widthBorderInput)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusInput),
                    borderSide: BorderSide(
                        color: AppColors.primary, width: widthBorderInput)),
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 12.0, 
                    color: AppColors.subtitles
                )
            ),
          ),
        ],
      ),
    );
  }
}
