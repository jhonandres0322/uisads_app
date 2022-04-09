import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainThirdContrast,
        elevation: 2.0,
      ),
      body: const Center(child: Text('Esta es la pagina del registro')),
    );
  }


}
