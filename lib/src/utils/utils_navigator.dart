import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/user.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

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