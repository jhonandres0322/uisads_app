import 'package:flutter/material.dart';
// Widget Logo de la aplicacion puede ser reeutilizado
class LogoApp extends StatelessWidget {
  const LogoApp({
    Key? key,
    required this.size,
  }) : super(key: key);
  // Declaramos una variable de tipo Size
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/images/logo_app.png'),
      height: size.height * 0.5,
    );
  }
}
