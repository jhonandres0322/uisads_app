import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/models/city.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/services/city_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/handler_image.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/alert_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';
import 'package:uisads_app/src/widgets/profile_avatar.dart';



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final EditProfileProvider _editProfileProvider = Provider.of<EditProfileProvider>(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return  WillPopScope(
      onWillPop: () async {
        _editProfileProvider.image = Upload();
        return true;
      },
      child: Scaffold(
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
              onPressed: () => _editProfile( context, formKey ),
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
            children: [
              const _InfoProfile(),
              _FormEditProfile( formKey: formKey)
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile(BuildContext context, GlobalKey<FormState> formKey) async {
    setState(() { });
    final _editProfileProvider = Provider.of<EditProfileProvider>(context, listen : false);
    final authService = AuthService();
    formKey.currentState?.save();
    Profile infoProfileEdited = _editProfileProvider.getDataEditProfile();
    Response response = await authService.editProfile( Preferences.uid , infoProfileEdited );
    ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( response.message, response.error ));
    Preferences.updateInfo( infoProfileEdited );
    _editProfileProvider.clearDataEditProfile();
    Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false ,arguments: {
      'type': 'user'
    });
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

class _PhotoProfile extends StatefulWidget {
  const _PhotoProfile({Key? key}) : super(key: key);

  @override
  State<_PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<_PhotoProfile> {
  @override
  Widget build(BuildContext context) {
    final EditProfileProvider _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final ProfileProvider profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Builder(
      builder: (context) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            ProfileAvatar( 
              radius: 0.065,
              image:  _editProfileProvider.image.content.isNotEmpty ? _editProfileProvider.image : profileProvider.photo,
            ),
            FloatingActionButton.small(
              child: const Icon(CustomUisIcons.camera),
              onPressed: () {
                _openImagePicker(context);
              },
              backgroundColor: AppColors.logoSchoolPrimary,
            )
          ],
        );
      }
    );
  }

  Future<void> _openImagePicker( BuildContext context ) async {
    final ImagePicker _picker = ImagePicker();
    final EditProfileProvider _editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 350,maxWidth: 350);
    if( pickedImage != null && pickedImage.path.isNotEmpty ) {
      _editProfileProvider.image = Upload.fromMap({
        "content": convertFileToBase64( pickedImage.path ),
        "name": pickedImage.name,
        "type": pickedImage.name.split('.')[1]
      });
      setState(() {});
    }
  }
}


class _FormEditProfile extends StatelessWidget {
  const _FormEditProfile({
    Key? key,
    required this.formKey
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final ProfileProvider profileProvider = Provider.of<ProfileProvider>(context, listen : false);
    final Size size = MediaQuery.of(context).size;
    return Form(
      key:  formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _InputName( name: profileProvider.name ),
          _InputPhone( cellphone: profileProvider.cellphone ),
          _InputEmail( email: profileProvider.email ),
          _InputCity( city: profileProvider.city ),
          _InputDescription( description: profileProvider.description ),
          SizedBox(height: size.height * 0.02),
          const _ButtonChangePassword(),
          SizedBox(height: size.height * 0.02),
        ],
      )
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
      decoration: decorationInputCustom( CustomUisIcons.card_user , 'Nombres y Apellidos' ),
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
      decoration: decorationInputCustom( CustomUisIcons.call_strong, 'Correo Electronico'),
    );
    return InputCustom(labelText: 'Correo Electronico', input: inputEmail);
  }
}

class _InputCity extends StatelessWidget {
  const _InputCity({Key? key, required this.city}) : super(key: key);
  final String city;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final _cityService = CityService();
    return FutureBuilder<List<City>> (
      future: _cityService.getCities(),
      initialData: const [],
      builder: (context, AsyncSnapshot<List<City>> snapshot) {
        if ( snapshot.hasData ) {
          List<City> cities = snapshot.data!;
          final Widget dropdownCity = DropdownButtonFormField<dynamic>(
            value: city,
            decoration: decorationInputCustom(
              Icons.location_city_rounded,
              'Ingrese la ciudad'
            ),
            items: cities.map((City city) {
              return DropdownMenuItem<dynamic>(
                value: city.id,
                child: Text( city.name ),
              );
            }).toList(),
            onChanged: ( dynamic value ) => _editProfileProvider.city = value,
            onSaved: ( dynamic value ) => _editProfileProvider.city = value
          );
          return InputCustom(labelText: 'Ciudad', input: dropdownCity);
        } else {
          return const CircularProgressIndicator();
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
      keyboardType: TextInputType.multiline,
      maxLines: 5,
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
          Navigator.popAndPushNamed(context, 'new-password');
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