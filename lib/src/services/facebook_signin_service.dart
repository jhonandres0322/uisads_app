import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Clase de servicio para el manejo de la autenticacion con Facebook
class FacebookSigninService {
  // Metodo para iniciar sesion con Facebook, es de tipo Future y no se emplea Firebase para esta autenticacion
  static Future<LoginResult> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        log('Facebook Sign In: ${userData}');
        final AccessToken accessToken = result.accessToken!;
        // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
        // final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        // final User user = userCredential.user!;
        // log('Facebook Sign In: ${user.displayName}');
        log('Facebook Sign token: ${result.accessToken!.token}');
        log('Facebook Sign In UserId: ${result.accessToken!.userId}');
        return result;
      } else {
        throw Exception('No se pudo obtener la autenticacion de Facebook');
      }
    } catch (e) {
      log('Error en el servicio de Facebook Signin: $e');
      return LoginResult(status: LoginStatus.failed);
    }
  }

  // Metodo para cerrar sesion con Facebook
  static Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }
  // Metodo para revisar si esta logeado con Facebook
  static Future<bool> isSignedInFacebook() async {
    return await FacebookAuth.instance.accessToken != null; 
  }
}
