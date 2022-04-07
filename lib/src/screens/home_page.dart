import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: EdgeInsets.only(top: size.height * 0.1),
        alignment: Alignment.center,
        child: Column(
          children: [
            createLogo(size), 
            createButtonLogin(size), 
            createButtonRegister(size)
          ],
        ),
      ),
    );
  }

  Widget createLogo(Size size) {
    return Image(
      image: const AssetImage('assets/images/logo_app.png'),
      height: size.height * 0.5,
    );
  }

  Widget createButtonLogin(Size size) {
    return ElevatedButton(onPressed: () {}, child: const Text('Iniciar Sesión'));
  }

  Widget createButtonRegister(Size size) {
    return ElevatedButton(onPressed: () {}, child: const Text('Registrarse'));
  }
}
