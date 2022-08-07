import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class ProfileProvider with ChangeNotifier {
  int      currentPage     = 0;
  String   uid             = '';
  Upload   photo           = Upload();
  String   name            = '';
  String   description     = '';
  String   email           = '';
  String   city            = '';
  String   cellphone       = '';
  String   nroPublications = '';
  String   nroScore        = '';
  String   nroCalification = '';
  List<Ad> ads             = [];


  void saveInfoProfile( Profile profile) {
    uid = profile.uid;
    photo = profile.image;
    name = profile.name;
    description = profile.description;
    cellphone =  profile.cellphone;
    email = profile.email;
    city = profile.city;
  }

}
