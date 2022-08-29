import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

/// Metodo para realizar la navegacion Autenticada con la info del login
/// Guarda tambien la info del usuario en las preferencias

class UtilsNavigator {
  
  static void navigatorAuth( BuildContext context, String token, Profile profile, User user) {
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

  static void navigatorProfile( BuildContext context, String idProfile ) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.uid = idProfile;
  }

  static void saveInfoProfile( BuildContext context, Profile profile) {
    final ProfileProvider _profileProvider = Provider.of<ProfileProvider>(context);
    _profileProvider.uid = profile.uid;
    _profileProvider.photo = profile.image;
    _profileProvider.name = profile.name;
    _profileProvider.description = profile.description;
    _profileProvider.cellphone =  profile.cellphone;
    _profileProvider.email = profile.email;
    _profileProvider.city = profile.city;
  }
}

