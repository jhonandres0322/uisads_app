import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

/// Metodo para realizar la navegacion Autenticada con la info del login
/// Guarda tambien la info del usuario en las preferencias
void navigatorAuth( BuildContext context, String token, Profile profile, User user) {
    Map<String, dynamic > infoLogin = {
      "token" : token,
      "name"  : profile.name,
      "email" : user.email,
      "uid"   : profile.uid,
      "image" : profile.image
    };
    Preferences.saveInfoLogin( infoLogin );
    Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
}