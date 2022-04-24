import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/utils/utils_recovery_page.dart';
import 'package:uisads_app/src/widgets/background_top_recovery.dart';
import 'package:uisads_app/src/widgets/button_arrow_back.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';


// ignore: must_be_immutable
class RecoveryPasswordCode extends StatelessWidget {
  RecoveryPasswordCode({ Key? key }) : super(key: key);
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundTopRecovery(),
            _createInfo(),
            const ButtonArrowBack()
          ],
        ),
      )
    );
  } 

  Widget _createInfo() {
    String title = 'Ingrese el código de verificación';
    String description = 'Por favor ingrese el código verificación que fue enviado a su correo';
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: _size.height * 0.08,
          ),
          createLogo(),
          createTitleInfo( _size, title ),
          createTextInfo( _size, description ),
          _containerInputEmail()
        ],
      ),
    );
  }

  Widget _containerInputEmail() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: _size.height * 0.18,
        top: _size.height * 0.03
      ),
      child: Center(
        child: Container(
          child: _FormLogin(),
          width: _size.width * 0.95,
          height: _size.height * 0.23,
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

class _FormLogin extends StatelessWidget {

  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SizedBox(
      width: _size.width * 0.4,
      child: Column(
        children: [
          _createInputCode(),
          SizedBox(
            height: _size.height * 0.03,
          ),
          createButton(context, _size, 'change-password','Código verificación',true)
        ],
      ),
    );
  }    

  Widget _createInputCode() {
    return InputCustom(
        hintText: 'Digite el codigo de verificación',
        obscureText: false,
        keyboardType: TextInputType.text,
        onChanged: changedExample,
        icon: Icons.numbers);
  }

  void changedExample(String text) {
    // ignore: avoid_print
    print('text --> $text');
  }
}