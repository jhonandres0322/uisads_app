import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';

class CreateAdProvider with ChangeNotifier {
  
  String _title = '';
  String _description = '';
  List<Upload> _images = [];
  String _publisher = '';
  String _category = '';
  bool _isVisible = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void limpiarObjetos(){
    _title = '';
    _description = '';
    _images = [];
    _publisher = '';
    _category = '';
    _isVisible = true;
  }

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
  set images( List<Upload> value ) {
    _images = value;
    notifyListeners();
  }

  String get publisher => _publisher;
  set publisher ( String value ) {
    _publisher = publisher;
    notifyListeners();
  }

  String get category => _category;
  set category ( String value ) {
    _category = value;
    notifyListeners();
  }

  Ad handlerData() {
    return Ad.fromMap({
      "title": _title,
      "description": _description,
      "images": _images,
      "publisher": _publisher,
      "category": _category,
      "visible": _isVisible
    });
  }

}