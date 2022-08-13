import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final Size size = MediaQuery.of(context).size;
    // ignore: avoid_unnecessary_containers
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: loginFormProvider.formKey,
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
      onSaved: (value) => loginForm.email = value ?? '',
      // validator: loginForm.validateEmail,
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
      onSaved: (value) => loginForm.password = value ?? '',
      // validator: loginForm.validatePassword,
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
          loginForm.formKey.currentState?.save();
          _loginUser( context, loginForm.email, loginForm.password );
        },
        child: const Text(
          'Iniciar sesión',
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

  void _loginUser(BuildContext context, String email, String password ) async {
    final _authService = AuthService();
    LoginRequest loginRequest = LoginRequest.fromMap({
      "email": email,
      "password": password
    });
    LoginResponse loginResponse = await _authService.loginUser(loginRequest);
    ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( loginResponse.message, loginResponse.error ) );
    if( !loginResponse.error ) {
      UtilsNavigator.navigatorAuth( context, loginResponse.token, loginResponse.profile, loginResponse.user );
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
