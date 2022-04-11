import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          alignment: Alignment.center,
          child: Column(
            children: [
              createLogo(size),
              SizedBox(
                height: size.height * 0.07,
              ),
              createButtonLogin(size, context),
              SizedBox(
                height: size.height * 0.05,
              ),
              createButtonRegister(size, context)
            ],
          ),
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

  Widget createButtonLogin(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: const Text('Iniciar Sesión'),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  Widget createButtonRegister(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'register');
          },
          child: const Text(
            'Registrarse',
            style: TextStyle(color: AppColors.primary),
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.mainThirdContrast,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              side: const BorderSide(width: 1.0, color: AppColors.titles))),
    );
  }
}
