import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

// ignore: must_be_immutable
class RecoveryPasswordPage extends StatelessWidget {
  RecoveryPasswordPage({Key? key}) : super(key: key);
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        _backgroundTop(),
        _createInfo(),
        _buttonArrowBack(context),
        _containerInputEmail()
      ],
    ));
  }

  Widget _backgroundTop() {
    return Container(
        height: _size.height * 0.35,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(colors: [
              Color(0xFF67B93E),
              Color(0xFF3EB96B),
              Color(0xFFA9B93E)
            ])));
  }

  Widget _buttonArrowBack(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(top: _size.height * 0.05, left: _size.width * 0.02),
        child: IconButton(
            color: AppColors.mainThirdContrast,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined)));
  }

  Widget _createInfo() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: _size.height * 0.09,
          ),
          _createLogo(),
          _createTitleInfo(),
          _createTextInfo()
        ],
      ),
    );
  }

  Widget _createTitleInfo() {
    return Padding(
      padding:
          EdgeInsets.only(top: _size.height * 0.01, right: _size.width * 0.3),
      child: const Text(
        'Recupere su contraseña',
        style: TextStyle(
            color: AppColors.mainThirdContrast,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createTextInfo() {
    return Padding(
      padding: EdgeInsets.only(
          top: _size.height * 0.01,
          left: _size.width * 0.085,
          right: _size.height * 0.02),
      child: const Text(
        'Por favor ingrese su dirección de correo electrónico para recibir el código de confirmación',
        style: TextStyle(
            color: AppColors.mainThirdContrast,
            fontSize: 14.0,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget _createLogo() {
    return const Image(
      image: AssetImage('assets/images/logo_app_alt.png'),
    );
  }

  Widget _containerInputEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: _size.height * 0.18),
      child: Center(
        child: Container(
          child: _FormLogin(),
          width: _size.width * 0.95,
          height: _size.height * 0.23,
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
class _FormLogin extends StatelessWidget {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SizedBox(
      width: _size.width * 0.4,
      child: Column(
        children: [
          _createInputEmail(),
          SizedBox(
            height: _size.height * 0.03,
          ),
          _createButton(context)
        ],
      ),
    );
  }

  Widget _createInputEmail() {
    return InputCustom(
        hintText: 'Ingresa tu correo electronico',
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: changedExample,
        icon: Icons.email);
  }

  Widget _createButton(BuildContext context ) {
    return SizedBox(
      height: _size.height * 0.065,
      width: _size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'main');
          },
          child: const Text('Recuperar contraseña'),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  void changedExample(String text) {
    // ignore: avoid_print
    print('text --> $text');
  }
}
