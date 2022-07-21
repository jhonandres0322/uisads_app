import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/register_form_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/alert_custom.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';



class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        title: const Text('Editar Perfil'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _editProfile( context ),
            child: const Text(
              'Guardar',
              style: TextStyle(color: AppColors.mainThirdContrast),
            ))
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFF67B93E),
                  Color(0xFF3EB96B),
                  Color(0xFFA9B93E)
                ]
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _InfoProfile(), 
            _FormEditProfile()
          ],
        ),
      ),
    );
  }
  
  _editProfile(BuildContext context) async {
    final _authService = AuthService();
    final _preferences = Preferences();
    final _editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    _editProfileProvider.formKey.currentState?.save();
    Map<String,dynamic> infoEditedProfile = _editProfileProvider.getData();
    log('infoEditedProfile --> $infoEditedProfile');
    Map<String, dynamic> resp = await _authService.editProfile( _preferences.profile , infoEditedProfile);
    if( !resp['error'] ) {
      ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( resp['msg'], false) );
    }
  }
}

class _InfoProfile extends StatelessWidget {
  const _InfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(height: size.height * 0.1), const _PhotoProfile()],
      ),
      height: size.height * 0.3,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF67B93E),
        Color(0xFF3EB96B),
        Color(0xFFA9B93E)
      ])),
    );
  }
}

class _PhotoProfile extends StatelessWidget {
  const _PhotoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const PerfilCirculoUsuario(radio: 50.0),
        FloatingActionButton.small(
          child: const Icon(CustomUisIcons.camera),
          onPressed: () {
            //TODO: Implementar el envio a el cambio de foto del perfil, ya sea a la camara o la galeria
            // Navigator.pushNamed(context, 'edit-profile');
          },
          backgroundColor: AppColors.logoSchoolPrimary,
        )
      ],
    );
  }
}


class _FormEditProfile extends StatelessWidget {
  const _FormEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final formKey = editProfileProvider.formKey;
    final Size size = MediaQuery.of(context).size;
    final _authService = AuthService(); 
    final _preferences = Preferences();
    return Form(
      key:  formKey,
      child: FutureBuilder(
        future: _authService.getProfile( _preferences.profile ),
        builder: (context, snapshot) {
          if ( snapshot.hasData ) {
              Map<String,dynamic> data =  snapshot.data as Map<String,dynamic>;
              Profile _profile = Profile.fromJson( data['profile'] as Map<String,dynamic> );
              String _email = data['email'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _InputName( name: _profile.name ),
                  _InputPhone( cellphone: _profile.cellphone,),
                  _InputEmail( email: _email ),
                  _InputCity( city: _profile.city),
                  _InputDescription( description: _profile.description),
                  SizedBox(height: size.height * 0.02),
                  const _ButtonChangePassword(),
                  SizedBox(height: size.height * 0.02),
                ],
              );
          }
          return const 
          Center(child:CircularProgressIndicator());
        },
      ),
    );
  }
}

class _InputName extends StatelessWidget {
  const _InputName({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final Widget inputName = TextFormField(
      initialValue: name ,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      onSaved: (value) =>_editProfileProvider.name = value ?? '',
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(
          CustomUisIcons.card_user, 'Nombres y Apellidos'),
    );
    return InputCustom(labelText: 'Nombres y Apellidos', input: inputName);
  }
}

class _InputPhone extends StatelessWidget {
  const 
  _InputPhone({Key? key, required this.cellphone}) : super(key: key);
  final String cellphone;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final Widget inputName = TextFormField(
      initialValue: cellphone,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.phone,
      onSaved: (value) => _editProfileProvider.cellphone = value ?? '',
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(CustomUisIcons.call_strong, 'Telefono'),
    );
    return InputCustom(labelText: 'Telefono', input: inputName);
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final Widget inputEmail = TextFormField(
      initialValue: email,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _editProfileProvider.email = value ?? '',
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(
          CustomUisIcons.call_strong, 'Correo Electronico'),
    );
    return InputCustom(labelText: 'Correo Electronico', input: inputEmail);
  }
}

class _InputCity extends StatelessWidget {
  const _InputCity({Key? key, required this.city}) : super(key: key);
  final String city;
  @override
  Widget build(BuildContext context) {
    final _registerForm = Provider.of<RegisterFormProvider>(context);
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    return FutureBuilder (
      future: _registerForm.getCities(),
      initialData: const [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if ( snapshot.hasData ) {
          List<dynamic> cities = snapshot.data;
          final Widget dropdownCity = DropdownButtonFormField<dynamic>(
            value: city,
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
            onChanged: ( dynamic value ) => _editProfileProvider.city = value,
            onSaved: ( dynamic value ) => _editProfileProvider.city = value
          );
          return InputCustom(labelText: 'Ciudad', input: dropdownCity);
        } else {
          return const Center();
        }
      },
    );
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key, required this.description }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final Widget inputEmail = TextFormField(
      initialValue: description,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      maxLines: 3,
      onSaved: (value) => _editProfileProvider.description = value ?? '',
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(CustomUisIcons.global_local, 'Descripción'),
    );
    return InputCustom(labelText: 'Descripción', input: inputEmail);
  }
}

class _ButtonChangePassword extends StatelessWidget {
  const _ButtonChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.07,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'new-password');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(CustomUisIcons.person_key),
            Text('Cambiar Contraseña')
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent)),
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF67B93E),
        Color(0xFF3EB96B),
        Color(0xFFA9B93E)
      ])),
    );
  }
}