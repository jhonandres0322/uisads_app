
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showErrorDialog( BuildContext context ) {
  showDialog(
    context: context, 
    builder: (context) {
      return const AlertDialog(
        title: Text('Title Alert'),
        content: Text('Content Alert'),
      );
    }
  );
}