import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/providers/register_form_provider.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

/// Pagina de registro de la aplicacion
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Scaffold(
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
                // Navigator.popAndPushNamed(context, 'login');
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
          // title: TextButton(
          //   onPressed: () {
          //     Navigator.popAndPushNamed(context, 'login');
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(left: size.width * 0.5),
          //     child: const Text(
          //       'Iniciar Sesión',
          //       style: TextStyle(
          //         color: AppColors.third,
          //         fontWeight: FontWeight.w600,
          //         fontFamily: 'Roboto',
          //         fontSize: 15.0
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: SingleChildScrollView(child: _RegisterForm()),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {

  // final TextEditingController _controllerEmail = TextEditingController();
  // final TextEditingController _controllerName = TextEditingController();
  // final TextEditingController _controllerPassword = TextEditingController();
  // final TextEditingController _controllerCellphone = TextEditingController();

  final double spacingInputs = 0.03;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // print('size: ${size.height}');
    return Column(
      children: [
        SizedBox(height: size.height * 0.05),
        const _InputEmailRegister(),
        SizedBox(height: size.height * 0.025),
        const _InputUsuarioRegister(),
        SizedBox(height: size.height * 0.025),
        const _InputCelularRegister(),
        SizedBox(height: size.height * 0.025),
        const _InputCiudadRegister(),
        SizedBox(height: size.height * 0.025),
        const _InputPasswordLogin(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputUser(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputCellphone(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputPassword(),
        SizedBox(height: size.height * 0.08),
        _ButtonRegister(size:size)
      ],
    );
  }

  // void _registerUser () {
    
  // }

  // void _onChangedExample(String text) {
  //   // ignore: avoid_print
  //   print('text $text');
  // }
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
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.70,
      child: ElevatedButton(
          onPressed: () {
            // Navegacion que elimina todas las rutas atras a mi main page
            Navigator.pushNamedAndRemoveUntil(context, 'main', (Route<dynamic> route) => false);
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
}

/// Widget que contiene el input de email para el registro
class _InputEmailRegister extends StatelessWidget {
  const _InputEmailRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      hintText: "example@example.com",
      keyboardType: TextInputType.emailAddress,
      labelText: 'Correo Electronico',
      value: registerForm.email,
      icon: Icons.email
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
      hintText: "Ingrese tu nombre",
      keyboardType: TextInputType.name,
      labelText: 'Usuario',
      value: registerForm.usuario,
      icon: Icons.person
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
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return InputCustom(
      hintText: 'Ingresa tu celular',
      labelText: 'Celular',
      keyboardType: TextInputType.phone,
      value: registerForm.celular,
      icon: Icons.mobile_friendly
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
    return InputCustom(
      hintText: 'Bucaramanga',
      labelText: 'Ciudad',
      keyboardType: TextInputType.text,
      value: registerForm.ciudad,
      icon: Icons.location_city_rounded
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
    return InputCustom(
        hintText: "********",
        keyboardType: TextInputType.text,
        labelText: 'Contraseña',
        obscureText: true,
        value: registerForm.password,
        icon: Icons.lock
    );
  }
}
