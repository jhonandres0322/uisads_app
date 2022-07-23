import 'package:flutter/material.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

void navigatorAuth( BuildContext context, String token, String profile) {
    Preferences _preferencs = Preferences();
    _preferencs.token = token;
    _preferencs.profile = profile;
    Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
}