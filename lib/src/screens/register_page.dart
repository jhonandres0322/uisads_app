import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/models/register_request.dart';
import 'package:uisads_app/src/models/register_response.dart';
import 'package:uisads_app/src/providers/register_form_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/utils/utils_navigator.dart';
import 'package:uisads_app/src/widgets/alert_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

/// Pagina de registro de la aplicacion
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              color: AppColors.subtitles,
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
    // print('size: ${size.height}');
    final registerFormProvider = Provider.of<RegisterFormProvider>(context); 
    return Form(
      key: registerFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          const _InputEmailRegister(),
          const _InputUsuarioRegister(),
          const _InputCelularRegister(),
          const _InputCiudadRegister(),
          const _InputPasswordLogin(),
          SizedBox(height: size.height * 0.08),
          _ButtonRegister(size:size)
        ],
      ),
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
    final Widget inputEmail = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => registerForm.email = value ?? '',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.email, 'example@example.com'),
    );
    return InputCustom(labelText: 'Correo Electronico', input: inputEmail);
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
    final Widget inputName = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.name,
      onSaved: (value) => registerForm.name = value ?? '',
      // validator: registerForm.email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.person, 'Ingrese su nombre'),
    );
    return InputCustom(labelText: 'Nombre', input: inputName);
  }
}

/// Widget que contiene el input del telefono del usuario para el registro
class _InputCelularRegister extends StatelessWidget {
  const _InputCelularRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final Widget inputPhone = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.phone,
      onSaved: (value) => registerForm.cellphone = value ?? '',
      // validator: registerForm.email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.mobile_friendly, 'Ingrese su celular'),
    );
    return InputCustom(labelText: 'Celular', input: inputPhone);
  }
}

/// Widget que contiene el input de Ciudad, aunque podria ser un select con el acceso al area metroplitana para el registro
class _InputCiudadRegister extends StatelessWidget {
  const _InputCiudadRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerForm = Provider.of<RegisterFormProvider>(context);
    return FutureBuilder (
      future: _registerForm.getCities(),
      initialData: const [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if ( snapshot.hasData ) {
          List<dynamic> cities = snapshot.data;
          final Widget dropdownCity = DropdownButtonFormField<dynamic>(
            decoration: decorationInputCustom(
              Icons.location_city_rounded,
              'Ingrese la ciudad'
            ),
            items: cities.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value['_id'],
                child: Text( value['name'] ),
              );
            }).toList(),
            onChanged: ( dynamic value ) => _registerForm.city = value,
            onSaved: ( dynamic value ) => _registerForm.city = value ?? '',
          );
          return InputCustom(labelText: 'Ciudad', input: dropdownCity);
        } else {
          return const Center();
        }
      },
    );
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
    final Widget inputPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.text,
      onSaved: (value) => registerForm.password = value ?? '',
      // validator: registerForm.email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(Icons.lock, 'Ingrese su contraseña'),
    );
    return InputCustom(labelText: 'Contraseña', input: inputPassword);
  }
}

///Clase que crea el boton para el registro
class _ButtonRegister extends StatelessWidget {
  final Size size;

  const _ButtonRegister({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterFormProvider>(context);
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.70,
      child: ElevatedButton(
          onPressed: () async {
            registerProvider.formKey.currentState?.save();
            _registerUser( context, registerProvider.organizeData() );
          },
          child: const Text('Crear Cuenta',
            style: TextStyle(
              color: Colors.white, 
              fontSize: 17, 
              fontWeight: FontWeight.w600, 
              fontFamily: 'Roboto'
            )
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  void _registerUser( BuildContext context, RegisterRequest registerRequest ) async {
    final _authService = AuthService();
    final RegisterResponse registerResponse = await _authService.registerUser( registerRequest );
    ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( registerResponse.msg, registerResponse.error ) );
    if( !registerResponse.error ) {
      navigatorAuth( context, registerResponse.token, registerResponse.profile.uid );
    }
  }

}