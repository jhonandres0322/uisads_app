

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';

class EditAdProvider extends ChangeNotifier {

  String title                 = '';
  String description           = '';
  List<Upload> images          = [];
  bool isVisible               = true;
  String category              = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void limpiarObjetos() {
    title                 = '';
    description           = '';
    images                = [];
    isVisible             = true;
    category              = '';
    formKey               = GlobalKey<FormState>();
  }
  Ad handlerData() {
    return Ad.fromMap({
      "title": title,
      "description": description,
      "images": images,
      "category": category,
      "visible": isVisible
    });
  }
}