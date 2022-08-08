import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
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
            ButtonArrowBack( routeName: '',),
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
          height: size.height * 0.4,
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
          const _InputNewPassword(),
          const _InputNewConfirmPassword(),
          SizedBox(
            height: size.height * 0.03,
          ),
          ButtonRecovery(
              routeName: 'login',
              text: 'Actualizar Contraseña',
              onPressed:  () => {},
              navigator: 'until',
          )
        ],
      ),
    );
  }
}

class _InputNewPassword extends StatelessWidget {
  const _InputNewPassword({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Widget inputCode = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Ingrese la nueva contraseña'),
    );
    return InputCustom(labelText: 'Nueva contraseña', input: inputCode);
  }
}

class _InputNewConfirmPassword extends StatelessWidget {
  const _InputNewConfirmPassword({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget inputCode = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Confirme la contraseña'),
    );
    return InputCustom(labelText: 'Confirma la nueva contraseña',input: inputCode);
  }
}
