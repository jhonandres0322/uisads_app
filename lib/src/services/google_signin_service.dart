import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
/// Clase de servicio para el manejo de la autenticacion con Google
class GoogleSigninService {
  
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );

  // Metodo para iniciar sesion con Google, es de tipo Future y no se emplea Firebase para esta autenticacion
  static Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // Si el idToken es null, el problema es el google-services.json, en caso de eso Revisar
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          return googleAuth;
        } else {
          throw Exception('No se pudo obtener la autenticacion de Google');
        }
      } else {
        throw Exception('No se pudo obtener la autenticacion de Google');
      }

    } catch (e) {
      log('Error en el servicio de Google Signin: $e');
      return null;
    }
  }

  // Metodo para cerrar sesion con Google
  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
  // Metodo para revisar si esta logeado con Google
  static Future<bool> isSignedInGoogle() async {
    return await _googleSignIn.isSignedIn();
  }
  
}