import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

// ignore: must_be_immutable
class RecoveryPasswordCode extends StatelessWidget {
  const RecoveryPasswordCode({Key? key}) : super(key: key);
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
                  ButtonArrowBack( routeName: '',),
                  _ContainerInfo(),
                  _ContainerForm()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ContainerInfo extends StatelessWidget {
  const _ContainerInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String title = 'Ingrese el código de verificación';
    String description =
        'Por favor ingrese el código de verificación que fue enviado a su correo';
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
          child: _FormRecoveryPasswordCode(),
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
class _FormRecoveryPasswordCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      child: Column(
        children: [
          const _InputCode(),
          SizedBox(
            height: size.height * 0.03,
          ),
          ButtonRecovery(
            routeName: 'change-password', 
            text: 'Código Verificación', 
            navigator: 'pop',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _InputCode extends StatelessWidget {
  const _InputCode({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Widget inputCode = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Ingrese el codigo'),
    );
    return InputCustom(labelText: 'Codigo',input: inputCode);
  }
}