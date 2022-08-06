import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/profile.dart';

import '../models/upload.dart';


class EditProfileProvider with ChangeNotifier{

  String name                  = '';
  String cellphone             = '';
  String email                 = '';
  String city                  = '';
  String description           = '';
  Upload image                 = Upload() ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>( );


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