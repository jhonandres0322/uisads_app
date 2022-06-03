import 'package:flutter/material.dart';


class RegisterFormProvider  extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String usuario = '';
  String celular = '';
  String ciudad = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
