import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uisads_app/src/models/profile.dart';

class Preferences {

  SharedPreferences? _prefs;

  static String token = '';
  static String name = '';
  static String description = '';
  static String email = '';
  static String cellphone = '';
  static String city = '';
  static String image = '';
  static String uid = '';
  static String score = '';
  

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void clearInfo() {
    token = '';
    name = '';
    description = '';
    email = '';
    cellphone = '';
    city = '';
    image = '';
    uid = '';
    score = '';
  }

}