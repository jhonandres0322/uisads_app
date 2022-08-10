import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          alignment: Alignment.center,
          child: Column(
            children: [
              LogoApp(height: size.height * 0.45,),
              SizedBox(
                height: size.height * 0.07,
              ),
              _ButtonLoginHome(size:size),
              SizedBox(
                height: size.height * 0.05,
              ),
              _ButtonRegisterHome(size: size ,)
            ],
          ),
        ),
      ),
    );
  }

}

/// Widget con boton secundario a la pagina de registrro
class _ButtonRegisterHome extends StatelessWidget {
  const _ButtonRegisterHome({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, 'register'),
          child: const Text(
            'Registrarse',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.mainThirdContrast,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              side: const BorderSide(width: 1.0, color: AppColors.titles))),
    );
  }
}

/// Widget que contiene el boton de login en el home
class _ButtonLoginHome extends StatelessWidget {
  const _ButtonLoginHome({
    Key? key,
    required this.size,
  }) : super(key: key);
  
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: const Text('Iniciar Sesión',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 15, 
                fontWeight: FontWeight.w600, 
                fontFamily: 'Roboto'
              )
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }
}
