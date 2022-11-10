import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/services/local_notification_service.dart';

class LoginOtherWays extends StatelessWidget {
  const LoginOtherWays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitPouringHourGlassRefined(
          color: AppColors.primary,
          size: 50.0,
        ),
      ),
      child: Scaffold(
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
              onPressed: () async{
                // TODO: SIGN OUT
                // GoogleSigninService.signOutGoogle();
                // Cerrar sesion Facebook
                bool isSignedInFacebook = await FacebookSigninService.isSignedInFacebook();
                log(isSignedInFacebook.toString());
                FacebookSigninService.signOutFacebook();
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
                LogoApp(
                  height: size.height * 0.25,
                ),
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
                  onPressed: () async {
                    // Logica de ingreso con Google
                    final googleUser =
                        await GoogleSigninService.signInWithGoogle();
                    if (googleUser != null) {
                      _loginUser(context, googleUser.idToken!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(showAlertCustom(
                          'Error Autenticacion Google, contacte al administrador',
                          true));
                    }
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
                  onPressed: () async{
                    // Logica de ingreso con Facebook
                    final facebookUser = await FacebookSigninService.signInWithFacebook();
                    if (facebookUser.status == LoginStatus.success) {
                      _loginUserFacebook(context, facebookUser.accessToken!.token, facebookUser.accessToken!.userId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(showAlertCustom(
                          'Error Autenticacion Facebook, contacte al administrador',
                          true));
                    }
                  },
                  text: 'Facebook',
                  colorBorder: Color(0xff1877F2),
                  colorButton: Color(0xff1877F2),
                  // colorButton: Color(0xff3B5998),
                  colorText: AppColors.logoSchoolSecondary,
                  icon: Icon(
                    CustomUisIcons.square_facebook,
                    color: AppColors.logoSchoolSecondary,
                  ),
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
                  icon: Icon(
                    CustomUisIcons.email_fluent,
                    color: AppColors.logoSchoolSecondary,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                // Boton Ingreso invitado
                _BotonIngresoCustom(
                  onPressed: () {
                    Navigator.pushNamed(context, 'main-guest');
                  },
                  text: 'Ingresar como invitado',
                  colorBorder: AppColors.subtitles,
                  colorButton: AppColors.mainThirdContrast,
                  colorText: AppColors.primary,
                  icon: Icon(
                    CustomUisIcons.solid_person,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                // _ButtonRegisterHome(size: size ,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Metodo para iniciar sesion con google por ahora
  void _loginUser(BuildContext context, String tokenId, ) async {
    late final LocalNotificationService serviceNotifications;
    serviceNotifications = LocalNotificationService();
    serviceNotifications.intialize();
    final _authService = AuthService();
    // Ejecucion del loading de la pantalla
    context.loaderOverlay.show();
    LoginResponse loginResponse = await _authService.loginUserGoogle(tokenId);
    context.loaderOverlay.hide();
    if (!loginResponse.error) {
      final _notificationService = NotificationService();
      log(loginResponse.token!);
      Response responseNotificaciones =
          await _notificationService.checkNewNotifications(loginResponse.token!);
          await serviceNotifications.showScheduledNotification(
          id: 0,
          title: 'Nuevos Anuncios con base en tus Intereses',
          body: responseNotificaciones.message,
          payload: 'Nuevos Anuncios',
          seconds: 7);
      ScaffoldMessenger.of(context).showSnackBar(
          showAlertCustom(loginResponse.message, loginResponse.error));

      UtilsNavigator.navigatorAuth(context, loginResponse.token!,
          loginResponse.profile!, loginResponse.user!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          showAlertCustom(loginResponse.message, loginResponse.error));
    }
    GoogleSigninService.signOutGoogle();
  }
  // Metodo para iniciar sesion con facebook por ahora
  void _loginUserFacebook(BuildContext context, String tokenId, String userId) async {
    final _authService = AuthService();
    // Ejecucion del loading de la pantalla
    context.loaderOverlay.show();
    LoginResponse loginResponse = await _authService.loginUserFacebook(tokenId, userId);
    context.loaderOverlay.hide();
    ScaffoldMessenger.of(context).showSnackBar(
        showAlertCustom(loginResponse.message, loginResponse.error));
    if (!loginResponse.error) {
      UtilsNavigator.navigatorAuth(context, loginResponse.token!,
          loginResponse.profile!, loginResponse.user!);
    }
    FacebookSigninService.signOutFacebook();
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
