import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/providers/login_form_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

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
                _createLogoApp(size),
                _LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createLogoApp(Size size) {
    return Image(
      image: const AssetImage('assets/images/logo_app.png'),
      height: size.height * 0.5,
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
            _createInputEmail(loginForm),
            SizedBox(
              height: size.height * 0.03,
            ),
            _createInputPassword(loginForm),
            SizedBox(
              height: size.height * 0.03,
            ),
            _createButtonLogin(size, context, loginForm),
            _createTextForgotPassword(context)
          ],
        ),
      ),
    );
  }

  Widget _createInputEmail(LoginFormProvider loginForm) {
    return InputCustom(
        hintText: "example@example.com",
        keyboardType: TextInputType.emailAddress,
        labelText: 'Correo Electronico',
        value: loginForm.email,
        icon: Icons.email);
  }

  Widget _createInputPassword(LoginFormProvider loginForm) {
    return InputCustom(
        hintText: "********",
        keyboardType: TextInputType.text,
        labelText: 'Contraseña',
        obscureText: true,
        value: loginForm.password,
        icon: Icons.lock);
  }

  Widget _createButtonLogin(
      Size size, BuildContext context, LoginFormProvider loginForm) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
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
          child: const Text('Crear Cuenta'),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  Widget _createTextForgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'recovery-password'),
      child: const Text('¿Olvidaste tu contraseña?'),
      style: TextButton.styleFrom(primary: AppColors.subtitles),
    );
  }
}
