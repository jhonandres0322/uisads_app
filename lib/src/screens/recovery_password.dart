import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Stack(
            children: const [
              BackgroundTopRecovery(), 
              LogoAppRecovery(),
              ButtonArrowBack( routeName:  ''), 
              _ContainerInfo(),
              _ContainerForm()
            ],
          ),
        ],
      ),
    )));
  }
}


class _ContainerInfo extends StatelessWidget {
  const _ContainerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Recupere su contraseña';
    String description =
        'Por favor ingrese su dirección de correo electrónico para recibir el código de confirmación';
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.17,
          ),
          TitleInfo(title: title),
          DescriptionInfo(description: description)
        ],
      ),
    );
  }
}


class _ContainerForm extends StatelessWidget {
  const _ContainerForm({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.height * 0.18, top: size.height * 0.35),
      child: Center(
        child: Container(
          child: _FormRecoveryPassword(),
          width: size.width * 0.9,
          height: size.height * 0.23,
          decoration: BoxDecoration(
            color: AppColors.mainThirdContrast,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 6.0),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _FormRecoveryPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      child: Column(
        children: [
          const _InputEmail(),
          SizedBox(
            height: size.height * 0.03,
          ),
          ButtonRecovery(
            routeName: 'recovery-password-code', 
            text: 'Recuperar Contraseña', 
            navigator: 'push',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget inputEmail = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.email, 'example@example.com'),
    );
    return InputCustom(labelText: 'Correo Electronico',input: inputEmail);
  }
}
