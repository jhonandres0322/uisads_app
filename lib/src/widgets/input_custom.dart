
import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';


// ignore: must_be_immutable
class InputCustom extends StatelessWidget {
  final String labelText;
  final Widget input;

  const InputCustom({
    Key? key,
    required this.labelText,
    required this.input
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.01,
              top: size.height * 0.025
            ),
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
