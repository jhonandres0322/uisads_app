import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';


class LoginOtherWays extends StatelessWidget {
  const LoginOtherWays({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              color: AppColors.primary,
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
        ),
        actions: [
          IconButton(
            color: AppColors.primary,
            icon: const Icon(CustomUisIcons.log_out),
            onPressed: () {
              // TODO: SIGN OUT
              GoogleSigninService.signOutGoogle();
            },
          ),
        ],
        backgroundColor: AppColors.mainThirdContrast,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.07),
          alignment: Alignment.center,
          child: Column(
            children: [
              LogoApp(height: size.height * 0.25,),
              SizedBox(
                height: size.height * 0.07,
              ),
              Container(
                child: Text(
                  'Ingrese con:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.subtitles,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // Boton Google
              _BotonIngresoCustom(
                onPressed: () {
                  // TODO: sign in with google
                  GoogleSigninService.signInWithGoogle();
                },
                text: 'Google',
                colorBorder: AppColors.subtitles.withOpacity(0.4),
                colorButton: AppColors.mainThirdContrast,
                colorText: AppColors.subtitles,
                icon: Image.asset(
                      'assets/images/icon_google_color.png',
                      width: 25,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // Boton Facebook
              _BotonIngresoCustom(
                onPressed: (){},
                text: 'Facebook',
                colorBorder: Color(0xff1877F2),
                colorButton: Color(0xff1877F2),
                // colorButton: Color(0xff3B5998),
                colorText: AppColors.logoSchoolSecondary,
                icon: Icon(CustomUisIcons.square_facebook, color: AppColors.logoSchoolSecondary,),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // Boton Ingreso Correo Electronico
              _BotonIngresoCustom(
                onPressed: () => Navigator.pushNamed(context, 'login'),
                text: 'Correo Electronico',
                colorBorder: AppColors.primary,
                colorButton: AppColors.primary,
                colorText: AppColors.logoSchoolSecondary,
                icon: Icon(CustomUisIcons.email_fluent, color: AppColors.logoSchoolSecondary,),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // Boton Ingreso invitado
              _BotonIngresoCustom(
                onPressed: (){},
                text: 'Ingresar como invitado',
                colorBorder: AppColors.subtitles,
                colorButton: AppColors.mainThirdContrast,
                colorText: AppColors.primary,
                icon: Icon(CustomUisIcons.solid_person, color: AppColors.primary,),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // _ButtonRegisterHome(size: size ,)
            ],
          ),
        ),
      ),
    );
  }
}

// Boton Ingreso para los diferentes medios de ingreso
class _BotonIngresoCustom extends StatelessWidget {
  const _BotonIngresoCustom({
    Key? key,
    this.colorButton = AppColors.mainThirdContrast,
    this.colorBorder = AppColors.subtitles,
    this.colorText = AppColors.subtitles,
    required this.icon, 
    required this.onPressed, 
    required this.text,
  }) : super(key: key);
  

  final Color? colorButton;
  final Color? colorBorder;
  final Color? colorText;
  final Widget icon;
  final Function onPressed;
  final String text;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonCustom(
      height: size.height * 0.065,
      width: size.width * 0.75,
      onPressed: onPressed,
      text: text,
      colorText: colorText!,
      colorButton: colorButton!,
      colorBorder: colorBorder!,
      icon: icon,
    );
  }
}