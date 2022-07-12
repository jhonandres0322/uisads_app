import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/providers/login_form_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/widgets/alert_custom.dart';
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
        appBar: AppBar(
          actions: [
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              child: const Text(
                'Registrarse',
                style: TextStyle(
                    color: AppColors.third,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    fontSize: 16.0),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          leading: Container(),
          backgroundColor: AppColors.mainThirdContrast,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                // SizedBox(height: size.height * 0.07),
                LogoApp(height: size.height * 0.45 ),
                _LoginForm(),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final Size size = MediaQuery.of(context).size;
    // ignore: avoid_unnecessary_containers
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: loginForm.formKey,
      child: Column(
        children: [
          const _InputEmailLogin(),
          SizedBox(
            height: size.height * 0.005,
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
    final Widget inputEmail = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => loginForm.email = value,
      validator: loginForm.validateEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.email, 'example@example.com'),
    );
    return InputCustom( labelText: 'Correo Electronico', input: inputEmail );
  }
}

// Widget que contiene el input de contraseña del correo para el login
class _InputPasswordLogin extends StatelessWidget {
  const _InputPasswordLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final Widget inputPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      onChanged: (value) => loginForm.password = value,
      validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, '*******'),
    );
    return InputCustom(labelText: 'Contraseña', input: inputPassword);
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
            // if( loginForm.formKey.)
            Map<String, dynamic> user = {
              "email": loginForm.email,
              "password": loginForm.password
            };
            _loginUser(context, user);
          },
          child: const Text('Iniciar sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto')),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
    );
  }

  void _loginUser(BuildContext context, Map<String, dynamic> user) async {
    final _authService = AuthService();
    final resp = await _authService.loginUser(user);
    log('resp --> $resp');
    if( resp['error'] ) {
      ScaffoldMessenger.of(context).showSnackBar(showAlertCustom(resp['msg'], true));
    } else {
      Preferences _preferences = Preferences();
      ScaffoldMessenger.of(context).showSnackBar(showAlertCustom(resp['msg'], false));
      _preferences.token = resp['token'];
      _preferences.user = json.encode( resp['user'] );
      _preferences.profile = json.encode( resp['profile'] );
      Navigator.pushNamedAndRemoveUntil(context, 'main', (Route<dynamic> route) => false);
    }
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
          )),
      style: TextButton.styleFrom(primary: AppColors.subtitles),
    );
  }
}
