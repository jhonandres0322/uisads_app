
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';


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
        "content": HandlerImage.convertFileToBase64( pickedImage.path ),
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
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    return InputCustom(
      labelText: 'Nombre y Apellidos', 
      onSaved: (value) => editProfileProvider.name = value ?? '', 
      iconData: CustomUisIcons.card_user, 
      hintText: 'Ingrese su nombre', 
      initialValue: name,
    );
  }
}

class _InputPhone extends StatelessWidget {
  const
  _InputPhone({Key? key, required this.cellphone}) : super(key: key);
  final String cellphone;
  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    return InputCustom(
      labelText: 'Telefono', 
      onSaved: (value) => editProfileProvider.cellphone = value ?? '', 
      iconData: CustomUisIcons.call_strong, 
      keyboardType: TextInputType.phone,
      hintText: 'Ingrese su nombre', 
      initialValue: cellphone,
    );
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    return InputCustom(
      labelText: 'Correo Electronico', 
      onSaved: (value) => editProfileProvider.email = value ?? '', 
      iconData: CustomUisIcons.email_outline, 
      keyboardType: TextInputType.phone,
      hintText: 'Ingrese su correo electronico', 
      initialValue: email,
    );
  }
}

class _InputCity extends StatelessWidget {
  const _InputCity({Key? key, required this.city}) : super(key: key);
  final String city;
  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final registerProvider = Provider.of<RegisterFormProvider>(context);
    List<DropdownMenuItem<String>> cities = registerProvider.cities.map((City city) 
    {
        return DropdownMenuItem<String>(
          value: city.id,
          child: Text( city.name ),
        );
      }).toList();
    final Widget dropdownCity = DropdownButtonFormField<dynamic>(
      decoration: decorationInputCustom(
        Icons.location_city_rounded,
        'Ingrese la ciudad'
      ),
      items: cities,
      value: city,
      onChanged: ( dynamic value ) => editProfileProvider.city = value,
      onSaved: ( dynamic value ) => editProfileProvider.city = value
    );
    return InputCustomDropdown(labelText: 'Ciudad', input: dropdownCity);
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key, required this.description }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    final _editProfileProvider = Provider.of<EditProfileProvider>(context);
    return TextAreaInputCustom(
      labelText: 'Descripción', 
      onSaved: (value) => _editProfileProvider.description = value ?? '', 
      hintText: 'Ingrese una descripción',
      initialValue: description,
    );
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