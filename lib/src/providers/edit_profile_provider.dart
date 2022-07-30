import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/profile.dart';

import '../models/upload.dart';


class EditProfileProvider with ChangeNotifier{

  String _name = '';
  String _cellphone = '';
  String _email = '';
  String _city = '';
  String _description = '';
  String _imageProfile = '';
  Map<String,dynamic> _image = {} ;
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  String get imageProfile => _imageProfile;
  set imageProfile( String value ) {
    _imageProfile = value;
    notifyListeners();
  }

  Map<String,dynamic> get image => _image;
  set image ( Map<String,dynamic> value ) {
    _image = value;
    notifyListeners();
  }
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

  Map<String,dynamic> getData() {
    return {
      "name" : _name,
      "cellphone" : _cellphone,
      "email" : _email,
      "city" : _city,
      "description" : _description,
      "image": _image
    }; 
  }

  void clearData() {
    _name = '';
    _cellphone = '';
    _email = '';
    _city = '';
    _imageProfile = '';
    _image = {};
  }

}