import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class InputCustom extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  const InputCustom({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.keyboardType,
    required this.onChanged
  }): super(key: key);

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
          TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2.0)),
                hintText: hintText),
          ),
        ],
      ),
    );
  }
}
