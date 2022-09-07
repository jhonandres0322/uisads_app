import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

/// Clase de servicio para el manejo de la autenticacion con Google
class GoogleSigninService {
  
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );

  // Metodo para iniciar sesion con Google, es de tipo Future y no se emplea Firebase para esta autenticacion
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        log('googleAuth: ${googleAuth.idToken}');
        // Si el idToken es null, el problema es el google-services.json, en caso de eso Revisar
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        // TODO: Llamar un servicio REST para autenticar con el token de Google en el backend
          log('Google Sign In: ${googleUser.displayName}');
          return googleUser;
        } else {
          throw Exception('No se pudo obtener la autenticacion de Google');
        }
      } else {
        throw Exception('No se pudo obtener la autenticacion de Google');
      }
      // final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );

      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('Error en el servicio de Google Signin: $e');
      return null;
    }
  }

  // Metodo para cerrar sesion con Google
  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
  
}