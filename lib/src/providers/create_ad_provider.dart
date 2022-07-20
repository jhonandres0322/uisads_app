


import 'package:flutter/material.dart';

class CreateAdProvider with ChangeNotifier {
  
  String _title = '';
  String _description = '';
  List<String> _images = [];
  String _publisher = '';
  String _category = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get title => _title;
  set title ( String value ) {
    _title = value;
    notifyListeners();
  }

  String get description => _description;
  set description ( String value ) {
    _description = value;
    notifyListeners();
  }

  List<String> get images => _images;

  String get publisher => _publisher;
  set publisher ( String value ) {
    _publisher = publisher;
    notifyListeners();
  }

  String get category => _category;
  set category ( String value ) {
    _category = category;
    notifyListeners();
  }
}