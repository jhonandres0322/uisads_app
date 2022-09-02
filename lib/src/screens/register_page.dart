import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

/// Pagina de registro de la aplicacion
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              color: AppColors.primary,
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
        ),
        backgroundColor: AppColors.mainThirdContrast,
        elevation: 2.0,
        actions: [
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, 'login', (Route<dynamic> route) => false);
            },
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                color: AppColors.third,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                fontSize: 16.0
              ),
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: SingleChildScrollView(child: _RegisterForm()),
    );
  }
}

class _RegisterForm extends StatelessWidget {

  final double spacingInputs = 0.03;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          const _InputEmailRegister(),
          const _InputUsuarioRegister(),
          const _InputCelularRegister(),
          const _InputCiudadRegister(),
          const _InputPasswordLogin(),
          SizedBox(height: size.height * 0.06),
          _ButtonRegister( size:size, formKey: formKey ),
          SizedBox(height: size.height * 0.04),
          // Registrese con
          const _RegistreseConBarra(),
          SizedBox(height: size.height * 0.01),
          // Botones de Google y Facebook
          const _BotonesRegistroOtrosMedios(),
          SizedBox(height: size.height * 0.04),
        ],
      ),
    );
  }
}

// Botones de Registro de Otros Medios
class _BotonesRegistroOtrosMedios extends StatelessWidget {
  const _BotonesRegistroOtrosMedios({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children :[
        // Botones de Google y Facebook
        IconButton(
          iconSize: 35,
          onPressed: () {
            // Ejecucion de la integracion con Facebook
            log('Facebook Register');
          }, 
          icon: Icon(
            CustomUisIcons.facebook_1,
            color: Color(0xff1877F2),
          )
        ),
        const SizedBox(width: 10,),
        IconButton(
          iconSize: 35,
          onPressed: () {
            // Ejecucion de la integracion con Facebook
            log('Facebook Register');
          }, 
          icon: Image.asset(
            'assets/images/icon_google_color.png',
          )
        ),
        // const _ButtonGoogle(),
        // const _ButtonFacebook(),
      ]
    );
  }
}

// Widget que muestra el registre con barra
class _RegistreseConBarra extends StatelessWidget {
  const _RegistreseConBarra({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: Color(0XFFD9D9D9),
          thickness: 1.0,
        ),
        // Texto Registrese con
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.mainThirdContrast,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'ó Registrese con',
            style: TextStyle(
              color: AppColors.subtitles,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
        )
      ],
    );
  }
}

// Widget que contiene el input de email para el registro
class _InputEmailRegister extends StatelessWidget {
  const _InputEmailRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      labelText: 'Correo Electronico', 
      onSaved: (value) => registerForm.email = value ?? '', 
      iconData: Icons.email, 
      hintText: 'example@example.com', 
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      colorIcon: AppColors.primary,
    );
  }
}

/// Widget que contiene el input de usuario para el registro
class _InputUsuarioRegister extends StatelessWidget {
  const _InputUsuarioRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      labelText: 'Nombre', 
      onSaved: (value) => registerForm.name = value ?? '', 
      iconData: Icons.person, 
      hintText: 'Ingrese un nombre', 
      colorIcon: AppColors.primary,
    );
  }
}

/// Widget que contiene el input del telefono del usuario para el registro
class _InputCelularRegister extends StatelessWidget {
  const _InputCelularRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center();
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      labelText: 'Celular', 
      onSaved: (value) => registerForm.cellphone = value ?? '', 
      iconData: Icons.mobile_friendly, 
      hintText: 'Ingrese un numero de celular', 
      keyboardType: TextInputType.phone,
      colorIcon: AppColors.primary,
    );
  }
}

/// Widget que contiene el input de Ciudad, aunque podria ser un select con el acceso al area metroplitana para el registro
class _InputCiudadRegister extends StatelessWidget {
  const _InputCiudadRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    List<DropdownMenuItem<String>> cities = registerForm.cities.map((City city) 
    {
        return DropdownMenuItem<String>(
          value: city.id,
          child: Text( city.name ),
        );
      }).toList();
    final Widget dropdownCity = DropdownButtonFormField<dynamic>(
      decoration: decorationInputCustom(
        Icons.location_city_rounded,
        'Ingrese la ciudad',
        AppColors.primary
      ),
      items: cities,
      onChanged: ( dynamic value ) => registerForm.city = value,
      onSaved: ( dynamic value ) => registerForm.city = value
    );
    return InputCustomDropdown(labelText: 'Ciudad', input: dropdownCity);
  }
}


/// Widget que contiene el input de contraseña del correo para el registro
class _InputPasswordLogin extends StatelessWidget {
  const _InputPasswordLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      labelText: 'Contraseña', 
      onSaved: (value) => registerForm.password = value ?? '', 
      iconData: Icons.lock, 
      hintText: 'Ingrese una contraseña', 
      obscureText: true,
      colorIcon: AppColors.primary,
    );
  }
}

///Clase que crea el boton para el registro
class _ButtonRegister extends StatelessWidget {
  final Size size;
  final GlobalKey<FormState> formKey;

  const _ButtonRegister({
    Key? key,
    required this.size,
    required this.formKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterFormProvider>(context);
    return ButtonCustom(
      height: size.height * 0.065,
      width: size.width * 0.7,
      onPressed: () {
        formKey.currentState?.save();
        _registerUser( context, registerProvider.organizeData() );
      },
      text: 'Crear Cuenta',
      colorText: Colors.white,
      colorButton: AppColors.primary, 
      colorBorder: AppColors.primary
    );
  }

  void _registerUser( BuildContext context, RegisterRequest registerRequest ) async {
    final _authService = AuthService();
    final RegisterResponse registerResponse = await _authService.registerUser( registerRequest );
    ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( registerResponse.msg, registerResponse.error ) );
    if( !registerResponse.error ) {
      UtilsNavigator.navigatorAuth( context, registerResponse.token, registerResponse.profile, registerResponse.user );
    }
  }

}