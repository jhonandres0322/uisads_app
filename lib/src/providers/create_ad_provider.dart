


import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/upload.dart';

class CreateAdProvider with ChangeNotifier {
  
  String _title = '';
  String _description = '';
  final List<Upload> _images = [];
  String _publisher = '';
  String _category = '';
  bool _isVisible = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool get isVisible => _isVisible;
  set isVisible ( bool value ) {
    _isVisible = value;
    notifyListeners();
  }

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

  List<Upload> get images => _images;

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

  Ad handlerData() {
    Map<String,dynamic> jsonAd = {
      "title": _title,
      "description": _description,
      "images": _images,
      "publisher": _publisher,
      "category": _category,
      "visible": _isVisible
    };
    return Ad.fromJson(jsonAd);
  }
}