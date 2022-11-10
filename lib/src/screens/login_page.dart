import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/services/local_notification_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitPouringHourGlassRefined(
          color: AppColors.primary,
          size: 50.0,
        ),
      ),
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
          leading: IconButton(
            color: AppColors.primary,
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.mainThirdContrast,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: size.height * 0.07),
              LogoApp(height: size.height * 0.45),
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
    // final Widget inputEmail = TextFormField(
    //   autofocus: false,
    //   obscureText: false,
    //   keyboardType: TextInputType.emailAddress,
    //   onSaved: (value) => loginForm.email = value ?? '',
    //   // validator: loginForm.validateEmail,
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   decoration: decorationInputCustom(Icons.email, 'example@example.com'),
    // );
    return InputCustom(
      labelText: 'Correo Electronico',
      onSaved: (value) {
        loginForm.email = value ?? '';
      },
      hintText: 'example@example.com',
      iconData: Icons.person,
      keyboardType: TextInputType.emailAddress,
      colorIcon: AppColors.primary,
    );
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
    // final Widget inputPassword = TextFormField(
    //   autofocus: false,
    //   obscureText: true,
    //   keyboardType: TextInputType.text,
    //   onSaved: (value) => loginForm.password = value ?? '',
    //   // validator: loginForm.validatePassword,
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   decoration: decorationInputCustom(Icons.lock, '*******'),
    // );
    return InputCustom(
      labelText: 'Contraseña',
      onSaved: (value) => loginForm.password = value ?? '',
      obscureText: true,
      hintText: '********',
      iconData: Icons.key,
      colorIcon: AppColors.primary,
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
    return ButtonCustom(
        height: size.height * 0.065,
        width: size.width * 0.7,
        onPressed: () {
          loginForm.formKey.currentState?.save();
          FocusScope.of(context).unfocus();
          _loginUser(context, loginForm.email, loginForm.password);
        },
        text: 'Iniciar Sesión',
        colorText: Colors.white,
        colorButton: AppColors.primary,
        colorBorder: AppColors.primary);
  }

  void _loginUser(BuildContext context, String email, String password) async {
    late final LocalNotificationService serviceNotifications;
    serviceNotifications = LocalNotificationService();
    serviceNotifications.intialize();
    final _authService = AuthService();
    LoginRequest loginRequest =
        LoginRequest.fromMap({"email": email, "password": password});
    // Ejecucion del loading de la pantalla
    context.loaderOverlay.show();
    LoginResponse loginResponse = await _authService.loginUser(loginRequest);
    context.loaderOverlay.hide();
    if (!loginResponse.error) {
      final _notificationService = NotificationService();
      log(loginResponse.token!);
      Response responseNotificaciones =
          await _notificationService.checkNewNotifications(loginResponse.token!);
          await serviceNotifications.showScheduledNotification(
          id: 0,
          title: 'Nuevos Anuncios con base en tus Intereses',
          body: responseNotificaciones.message,
          payload: 'Nuevos Anuncios',
          seconds: 7);
      ScaffoldMessenger.of(context).showSnackBar(
          showAlertCustom(loginResponse.message, loginResponse.error));

      UtilsNavigator.navigatorAuth(context, loginResponse.token!,
          loginResponse.profile!, loginResponse.user!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showAlertCustom(loginResponse.message, loginResponse.error));
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
