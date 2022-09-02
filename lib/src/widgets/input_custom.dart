import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

// ignore: must_be_immutable
class InputCustom extends StatelessWidget {
  final String labelText;
  final bool autofocus;
  final bool obscureText;
  final FormFieldSetter onSaved;
  final IconData iconData;
  final String hintText;
  final TextInputType keyboardType;
  final String initialValue;
  final double paddingPorcentage;
  final TextEditingController? controller;
  final Color? colorIcon;

  const InputCustom({
    Key? key,
    required this.labelText,
    this.autofocus = false,
    this.obscureText = false,
    required this.onSaved,
    required this.iconData,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.initialValue = '',
    this.paddingPorcentage = 0.1,
    this.controller, 
    this.colorIcon = AppColors.subtitles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * paddingPorcentage,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, top: size.height * 0.025),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: const TextStyle(
                    color: AppColors.subtitles,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          TextFormField(
            // initialValue: initialValue,
            controller: controller ?? TextEditingController(text: initialValue),
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onSaved: onSaved,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration:
                decorationInputCustom(iconData, hintText, colorIcon),
          )
          // ignore: sized_box_for_whitespace
        ],
      ),
    );
  }
}

class InputCustomDropdown extends StatelessWidget {
  const InputCustomDropdown(
      {Key? key, required this.input, required this.labelText})
      : super(key: key);
  final Widget input;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, top: size.height * 0.025),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: const TextStyle(
                    color: AppColors.subtitles,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          input
          // ignore: sized_box_for_whitespace
        ],
      ),
    );
  }
}

class TextAreaInputCustom extends StatelessWidget {
  final String labelText;
  final bool autofocus;
  final bool obscureText;
  final FormFieldSetter onSaved;
  final String hintText;
  final String initialValue;
  const TextAreaInputCustom(
      {Key? key,
      required this.labelText,
      this.autofocus = false,
      this.obscureText = false,
      required this.onSaved,
      required this.hintText,
      this.initialValue = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.01, top: size.height * 0.025),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: const TextStyle(
                    color: AppColors.subtitles,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          TextFormField(
            initialValue: initialValue,
            autofocus: autofocus,
            obscureText: obscureText,
            keyboardType: TextInputType.multiline,
            onSaved: onSaved,
            maxLines: 6,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: hintText,
                hintStyle:
                    const TextStyle(fontSize: 13, color: AppColors.subtitles),
                prefixIconColor: AppColors.primary,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: AppColors.primary, width: 1.5))),
          )
          // ignore: sized_box_for_whitespace
        ],
      ),
    );
  }
}
