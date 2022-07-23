import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/profile.dart';


class EditProfileProvider with ChangeNotifier{

  String _name = '';
  String _cellphone = '';
  String _email = '';
  String _city = '';
  String _description = '';
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  String get name => _name;
  set name( String value ) {
    _name = value;
    notifyListeners();
  }

  String get cellphone => _cellphone;
  set cellphone( String value ) {
    _cellphone = value;
    notifyListeners();
  }

  String get email => _email;
  set email( String value ) {
    _email = value;
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

  Profile getData() {
    return Profile.fromMap({
      "name" : _name,
      "cellphone" : _cellphone,
      "email" : _email,
      "city" : _city,
      "description" : _description
    }); 
  }
}