import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';


class EditProfileProvider with ChangeNotifier{

  String name                  = '';
  String cellphone             = '';
  String email                 = '';
  String city                  = '';
  String description           = '';
  Upload image                 = Upload() ;


  Profile getDataEditProfile() {
    return Profile.fromMap({
      "name"        : name,
      "cellphone"   : cellphone,
      "city"        : city,
      "email"       : email,
      "description" : description,
      "image"       : image.toMap()
    });
  }

  void clearDataEditProfile() {
    name        = '';
    cellphone   = '';
    email       = '';
    city        = '';
    description = '';
    image       = Upload();
  }

}