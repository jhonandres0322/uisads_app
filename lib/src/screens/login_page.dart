import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.07),
              _createLogoApp(size),
              SizedBox(height: size.height * 0.02),
              _LoginForm()
            ],
          ),
        ),
      ),
    );
  }

  _createLogoApp(Size size) {
    return Image(
      image: const AssetImage('assets/images/logo_app.png'),
      height: size.height * 0.5,
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        children: [
          _createInputEmail(),
          SizedBox(height: size.height * 0.02),
          _createInputPassword(),
          SizedBox(height: size.height * 0.02),
          _createButtonLogin(size, context),
          SizedBox(height: size.height * 0.02),
          _createTextForgetPassowrd(context),
          SizedBox(height: size.height * 0.04),
        ],
      ),
    );
  }

  Widget _createInputEmail() {
    return InputCustom(
      labelText: 'Email',
      hintText: 'Ingrese el correo',
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: _onChangedExample ,
      icon: Icons.email ,
    );
  }
  
  void _onChangedExample( String text ) {
    // ignore: avoid_print
    print('text $text');
  }

  Widget _createInputPassword() {
    return InputCustom(
      labelText: 'Contraseña',
      hintText: 'Ingrese la contraseña',
      obscureText: true,
      keyboardType: TextInputType.text,
      onChanged: _onChangedExample,
      icon: Icons.lock 
    );
  }

  Widget _createButtonLogin(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'main');
          },
          child: const Text('Iniciar Sesión'),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  Widget _createTextForgetPassowrd(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'recovery-password');
      },
      child: const Text('¿Olvidaste tu contraseña?'),
      style: TextButton.styleFrom(primary: AppColors.subtitles),
    );
  }
}
