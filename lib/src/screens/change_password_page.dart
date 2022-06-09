import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/utils/utils_recovery_page.dart';
import 'package:uisads_app/src/widgets/background_top_recovery.dart';
import 'package:uisads_app/src/widgets/button_arrow_back.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

// ignore: must_be_immutable
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            BackgroundTopRecovery(),
            LogoApp(),
            ButtonArrowBack(),
            _ContainerInfo(),
            _ContainerForm()
          ],
        ),
      ),
    );
  }
}

class _ContainerInfo extends StatelessWidget {
  const _ContainerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Cambiar Contraseña';
    String description =
        'Crea una nueva contraseña y por favor no la compartas con nadie por su seguridad';
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
  const _ContainerForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: size.height * 0.18, top: size.height * 0.35),
      child: Center(
        child: Container(
          child: _FormRecoveryChangePassword(),
          width: size.width * 0.9,
          height: size.height * 0.3,
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

class _FormRecoveryChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      child: Column(
        children: [
          _InputNewPassword(
            hintText: 'Nueva Contraseña',
          ),
          _InputNewPassword(hintText: 'Confirme Nueva Contraseña'),
          SizedBox(
            height: size.height * 0.03,
          ),
          ButtonRecovery(
              routeName: 'login',
              text: 'Actualizar Contraseña',
              navigator: 'until'
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _InputNewPassword extends StatelessWidget {
  String hintText;
  _InputNewPassword({
    Key? key,
    required this.hintText
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputCustom(
        hintText: hintText,
        obscureText: false,
        keyboardType: TextInputType.text,
        value: '',
        icon: Icons.shield);
  }
}
