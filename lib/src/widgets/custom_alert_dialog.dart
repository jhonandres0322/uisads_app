import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: [
        negativeBtnText != null
            ? TextButton(
                child: Text(negativeBtnText!),
                // textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
              )
            : Container(),
        positiveBtnText != null
            ? TextButton(
                child: Text(positiveBtnText!),
                // style: ButtonStyle(
                //   textStyle: MaterialStatePropertyTextStyle>(
                //     color: Theme.of(context).colorScheme.secondary,
                //   ),
                // ),
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed!();
                  }
                },
              )
            : Container(),
      ],
    );
  }
}

// Uso del AlertDialog
// var dialog = CustomAlertDialog(
//   title: "Logout",
//   message: "Are you sure, do you want to logout?",
//   onPostivePressed: () {},
//   positiveBtnText: 'Yes',
//   negativeBtnText: 'No');
// showDialog(
//   context: context,
//   builder: (BuildContext context) => dialog);