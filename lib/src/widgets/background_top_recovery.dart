import 'package:flutter/material.dart';

class BackgroundTopRecovery extends StatelessWidget {
  const BackgroundTopRecovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.35,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(colors: [
              Color(0xFF67B93E),
              Color(0xFF3EB96B),
              Color(0xFFA9B93E)
            ])));
  }
}
