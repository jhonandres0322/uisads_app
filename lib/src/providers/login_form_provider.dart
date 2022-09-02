import 'package:flutter/material.dart';

class LoginFormProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  final _formKey = LabeledGlobalKey<FormState>('login_form');
  final _regExpEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  GlobalKey<FormState> get formKey => _formKey;

  String get email {
    return _email;
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get password {
    return _password;
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Campo Requerido';
    }
    if (!_regExpEmail.hasMatch(value)) {
      return 'Ingrese un correo valido';
    }
    return '';
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Campo Requerido';
    }
    if (value.length < 6) {
      return 'La contraseña debe contener 6 caracteres';
    }
    return '';
  }

}
