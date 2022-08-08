import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/register_request.dart';
import 'package:uisads_app/src/services/auth_service.dart';

class RegisterFormProvider with ChangeNotifier {

  String _email                   = '';
  String _name                    = '';
  String _cellphone               = '';
  String _city                    = '';
  String _password                = '';
  bool   _isLoading               = false;

  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get cellphone => _cellphone;
  set cellphone(String value) {
    _cellphone = value;
    notifyListeners();
  }

  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get city => _city;
  set city(String value) {
    _city = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  RegisterRequest organizeData( ) {
    return RegisterRequest.fromMap({
      "email": _email,
      "name": _name,
      "cellphone": _cellphone,
      "password": _password,
      "city": _city
    });
  }


}
