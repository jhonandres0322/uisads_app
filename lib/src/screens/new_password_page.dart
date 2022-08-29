import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

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
                LogoAppRecovery(),
                ButtonArrowBack( routeName: 'edit-profile'),
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
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return SizedBox(
      width: size.width * 0.5,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const _InputPasswordOld(),
            const _InputPasswordNew(),
            const _InputPasswordNewConfirm(),
            SizedBox(
              height: size.height * 0.03,
            ),
            _ButtonChangeNewPassword( formKey: formKey)
          ],
        ),
      ),
    );
  }

}

class _InputPasswordOld extends StatelessWidget {
  const _InputPasswordOld({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context); 
    return InputCustom(
      labelText: '' , 
      onSaved: (value) => changePasswordProvider.oldPassword = value ?? '', 
      iconData: Icons.lock, 
      hintText: 'Anterior Contraseña',
      obscureText: true,
    );
  }
}

class _InputPasswordNew extends StatelessWidget {
  const _InputPasswordNew({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context); 
    return InputCustom(
      labelText: '' , 
      onSaved: (value) => changePasswordProvider.newPassword = value ?? '', 
      iconData: Icons.lock, 
      hintText: 'Nueva Contraseña',
      obscureText: true,
    );
  }
}

class _InputPasswordNewConfirm extends StatelessWidget {
  const _InputPasswordNewConfirm({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangePasswordProvider>(context); 
    return InputCustom(
      labelText: '' , 
      onSaved: (value) => changePasswordProvider.confirmNewPassword = value ?? '', 
      iconData: Icons.lock, 
      hintText: 'Confirme Nueva Contraseña',
      obscureText: true,
    );
  }
}


class _ButtonChangeNewPassword extends StatelessWidget {
  const _ButtonChangeNewPassword({
    Key? key,
    required this.formKey
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ButtonCustom(
      height: size.height * 0.065,
      width: size.width * 0.75,
      onPressed: () async {
        bool isNavigator = await changePassword(context, formKey);
        if ( isNavigator ) {
          Navigator.popAndPushNamed( context, 'edit-profile');
        }
      },
      text: 'Cambiar Contraseña',
      colorText: Colors.white,
      colorButton: AppColors.primary,
      colorBorder: AppColors.primary
    );
  }

    Future<bool> changePassword( BuildContext context, GlobalKey<FormState> formKey ) async {
      final changePasswordProvider = Provider.of<ChangePasswordProvider>(context, listen: false);
      final authService = AuthService();
      formKey.currentState?.save();
      final Response response = await authService.changePassword( changePasswordProvider.getData() );
      ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( response.message , response.error ));
      return response.error ? false : true;
    }
}

