import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/user.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

void navigatorAuth( BuildContext context, String token, Profile profile, User user) {
    Preferences.token = token;
    Preferences.name = profile.name;
    Preferences.cellphone = profile.cellphone;
    Preferences.city = profile.city;
    Preferences.description = profile.description;
    Preferences.email = user.email;
    Preferences.uid = profile.uid;
    Preferences.score = profile.score.toString();
    Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
}