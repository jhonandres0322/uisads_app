import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/utils/utils_recovery_page.dart';
import 'package:uisads_app/src/widgets/background_top_recovery.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(children: const [
                BackgroundTopRecovery(),
                LogoApp(),
                _ContainerInfo(),
                _ContainerForm()
              ])
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
    final Size size = MediaQuery.of(context).size;
    String title = 'Crea una nueva contraseña';
    String description =
        'Crea una nueva contraseña y por favor no la compartas con nadie por su seguridad.';
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
      padding: EdgeInsets.only(
          bottom: size.height * 0.18, top: size.height * 0.32),
      child: Center(
        child: Container(
          child: const _FormNewPassword(),
          width: size.width * 0.9,
          height: size.height * 0.48,
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

class _FormNewPassword extends StatelessWidget {
  const _FormNewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.5,
      child: Column(
        children: [
          const _InputPasswordOld(),
          const _InputPasswordNew(),
          const _InputPasswordNewConfirm(),
          SizedBox(
            height: size.height * 0.03,
          ),
          ButtonRecovery(
              routeName: 'edit-profile',
              text: 'Actualizar Contraseña',
              navigator: 'push'
          )
        ],
      ),
    );
  }
}

class _InputPasswordOld extends StatelessWidget {
  const _InputPasswordOld({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget inputPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Antigua Contraseña'),
    );
    return InputCustom(labelText: '', input: inputPassword);
  }
}

class _InputPasswordNew extends StatelessWidget {
  const _InputPasswordNew({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget inputPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Nueva Contraseña'),
    );
    return InputCustom(labelText: '', input: inputPassword);
  }
}

class _InputPasswordNewConfirm extends StatelessWidget {
  const _InputPasswordNewConfirm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget inputPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      //onChanged: (value) => loginForm.password = value,
      //validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Confirme Nueva contraseña'),
    );
    return InputCustom(labelText: '', input: inputPassword);
  }
}


