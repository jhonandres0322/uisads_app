import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
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
          children: const [_InfoProfile(), _FormEditProfile()],
        ),
      ),
    );
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
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _InputName(),
        const _InputPhone(),
        const _InputEmail(),
        const _InputCity(),
        const _InputDescription(),
        SizedBox(height: size.height * 0.02),
        const _ButtonChangePassword(),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

class _InputName extends StatelessWidget {
  const _InputName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerInputName =
        TextEditingController(text: 'Jorge Andres Gonzalez');
    final Widget inputName = TextFormField(
      controller: _controllerInputName,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      // onChanged: (value) => loginForm.password = value,
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(
          CustomUisIcons.card_user, 'Nombres y Apellidos'),
    );
    return InputCustom(labelText: 'Nombres y Apellidos', input: inputName);
  }
}

class _InputPhone extends StatelessWidget {
  const _InputPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerInputPhone =
        TextEditingController(text: '3003457854');
    final Widget inputName = TextFormField(
      controller: _controllerInputPhone,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.phone,
      // onChanged: (value) => loginForm.password = value,
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(CustomUisIcons.call_strong, 'Telefono'),
    );
    return InputCustom(labelText: 'Telefono', input: inputName);
  }
}

class _InputEmail extends StatelessWidget {
  const _InputEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerInputEmail =
        TextEditingController(text: 'jorgeandres123@gmail.com');
    final Widget inputEmail = TextFormField(
      controller: _controllerInputEmail,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      // onChanged: (value) => loginForm.password = value,
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(
          CustomUisIcons.call_strong, 'Correo Electronico'),
    );
    return InputCustom(labelText: 'Correo Electronico', input: inputEmail);
  }
}

class _InputCity extends StatelessWidget {
  const _InputCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerInputCity =
        TextEditingController(text: 'Bucaramanga');
    final Widget inputEmail = TextFormField(
      controller: _controllerInputCity,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      // onChanged: (value) => loginForm.password = value,
      // validator: loginForm.validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decorationInputCustom(CustomUisIcons.global_local, 'Ciudad'),
    );
    return InputCustom(labelText: 'Ciudad', input: inputEmail);
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerInputDescription =
        TextEditingController(text: 'Colombiano egresado de la uis, con vocacion de servicio.');
    final Widget inputEmail = TextFormField(
      controller: _controllerInputDescription,
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      maxLines: 3,
      // onChanged: (value) => loginForm.password = value,
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
