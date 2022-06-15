import 'package:flutter/material.dart';

class RegisterFormProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email = '';
  String _usuario = '';
  String _celular = '';
  String _ciudad = '';
  String _password = '';
  bool _isLoading = false;

  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get usuario => _usuario;
  set usuario(String value) {
    _usuario = value;
    notifyListeners();
  }

  String get celular => _celular;
  set celular(String value) {
    _celular = value;
    notifyListeners();
  }

  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get ciudad => _ciudad;
  set ciudad(String value) {
    _ciudad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
