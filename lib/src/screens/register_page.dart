import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainThirdContrast,
        elevation: 2.0,
        title: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.5),
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                  color: AppColors.third,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(child: _RegisterForm()),
    );
  }
}

class _RegisterForm extends StatelessWidget {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerCellphone = TextEditingController();

  final double spacingInputs = 0.03;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.05),
        // _createInputEmail(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputUser(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputCellphone(),
        // SizedBox(height: size.height * spacingInputs),
        // _createInputPassword(),
        SizedBox(height: size.height * 0.08),
        _createButtonRegister(size, context)
      ],
    );
  }

  // Widget _createInputEmail() {
  //   return InputCustom(
  //       controller: _controllerEmail,
  //       hintText: 'Ingrese el email',
  //       labelText: 'Email',
  //       obscureText: false,
  //       keyboardType: TextInputType.emailAddress,
  //       onChanged: _onChangedExample,
  //       icon: Icons.email 
  //     );
  // }

  // Widget _createInputUser() {
  //   return InputCustom(
  //       controller: _controllerName,
  //       hintText: 'Ingresa tu nombre',
  //       labelText: 'Usuario',
  //       obscureText: false,
  //       keyboardType: TextInputType.name,
  //       onChanged: _onChangedExample,
  //       icon: Icons.person 
      
  //     );
  // }

  // Widget _createInputPassword() {
  //   return InputCustom(
  //       controller: _controllerPassword,
  //       hintText: 'Ingresa tu contraseña',
  //       labelText: 'Contraseña',
  //       obscureText: true,
  //       keyboardType: TextInputType.name,
  //       onChanged: _onChangedExample,
  //       icon: Icons.lock 
  //       );
  // }

  // Widget _createInputCellphone() {
  //   return InputCustom(
  //       controller: _controllerCellphone,
  //       hintText: 'Ingresa tu celular',
  //       labelText: 'Celular',
  //       obscureText: false,
  //       keyboardType: TextInputType.phone,
  //       onChanged: _onChangedExample,
  //       icon: Icons.phone_iphone
  //   );
  // }

  Widget _createButtonRegister(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.75,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'main');
          },
          child: const Text('Crear Cuenta'),
          style: ElevatedButton.styleFrom(
              primary: AppColors.third,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)))),
    );
  }

  void _registerUser () {
    
  }

  void _onChangedExample(String text) {
    // ignore: avoid_print
    print('text $text');
  }
}