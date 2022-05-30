import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/providers/login_form_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';
import 'package:uisads_app/src/widgets/logo_app.dart';

import '../constants/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.07),
                LogoApp(size: size),
                _LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  void loginUser() async {}
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final Size size = MediaQuery.of(context).size;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: loginForm.formKey,
        child: Column(
          children: [
            const _InputEmailLogin(),
            // _createInputEmail(loginForm),
            SizedBox(
              height: size.height * 0.03,
            ),
            const _InputPasswordLogin(),
            SizedBox(
              height: size.height * 0.03,
            ),
            _ButtonLogin(size: size),
            const _TextForgotPasswordLogin(),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}




/// Widget que contiene el input de email para el formulario de login
class _InputEmailLogin extends StatelessWidget {
  const _InputEmailLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Llamada al provider
    final loginForm = Provider.of<LoginFormProvider>(context);
    return InputCustom(
        hintText: "example@example.com",
        keyboardType: TextInputType.emailAddress,
        labelText: 'Correo Electronico',
        value: loginForm.email,
        icon: Icons.email
    );
  }
}

/// Widget que contiene el input de contraseña del correo para el login
class _InputPasswordLogin extends StatelessWidget {
  const _InputPasswordLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return InputCustom(
        hintText: "********",
        keyboardType: TextInputType.text,
        labelText: 'Contraseña',
        obscureText: true,
        value: loginForm.password,
        icon: Icons.lock
    );
  }
}

/// Widget que contiene el boton de login
class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({
    Key? key,
    required this.size,
  }) : super(key: key);

  // Declaramos una variable de tipo Size
  final Size size;
  @override
  Widget build(BuildContext context) {
    // Declaracion del provider del formulario
    final loginForm = Provider.of<LoginFormProvider>(context);
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.70,
      child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, 'main');
            loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;

                    
                  };
          },
          child: const Text('Iniciar sesión',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 17, 
                fontWeight: FontWeight.w600, 
                fontFamily: 'Roboto'
              )
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              )
          )
      ),
    );
  }
}

/// Widget que contiene el texto de olvido su contraseña
class _TextForgotPasswordLogin extends StatelessWidget {
  const _TextForgotPasswordLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'recovery-password'),
      child: const Text('¿Olvidaste tu contraseña?',
          style: TextStyle(
            color: AppColors.subtitles,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          )
      ),
      style: TextButton.styleFrom(primary: AppColors.subtitles),
    );
  }
}