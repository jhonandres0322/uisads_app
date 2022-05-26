import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Title Alert'),
          content: Text('Content Alert'),
        );
      });
}

class AlertErrorModal extends StatelessWidget {
  final String title;
  final String content;
  const AlertErrorModal({
    Key? key,
    required this.title,
    required this.content 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text( title ),
      content: Text( content ),
    );
  }
}
