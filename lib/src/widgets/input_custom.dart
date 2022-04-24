import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class InputCustom extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final IconData icon;

  const InputCustom(
      {Key? key,
      required this.hintText,
      this.labelText = '',
      required this.obscureText,
      required this.keyboardType,
      required this.onChanged,
      required this.icon
      })
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
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: const TextStyle(color: AppColors.subtitles),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          // ignore: sized_box_for_whitespace
          TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
                prefixIcon : Icon( icon, color: AppColors.subtitles),
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
                    fontSize: 14.0, color: AppColors.subtitles)),
          ),
        ],
      ),
    );
  }
}
