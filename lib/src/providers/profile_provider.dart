import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class ProfileProvider with ChangeNotifier {
  int _currentPage = 0;
  String _image = '';
  String _name = '';
  String _description = '';
  String _email = '';
  String _city = '';

  String get name => _name;
  set name( String value ) {
    _name = value;
    notifyListeners();
  }

  String get city => _city;
  set city( String value ) {
    _city = value;
    notifyListeners();
  }

  String get description => _description;
  set description( String value ) {
    _description = value;
    notifyListeners();
  }

  String get email => _email;
  set email( String value ) {
    _email = value;
    notifyListeners();
  }

  String get image => _image;
  set image( String value ) {
    _image = value;
    notifyListeners();
  }

  void updateInfo( Map<String,dynamic> info ) {
    name = info['name'];
    description = info['description'];
    email = info['email'];
    city = info['city'];
    Preferences.name = name;
    Preferences.description = description;
    Preferences.email = email;
    Preferences.city = city;
    notifyListeners();
  }

  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
