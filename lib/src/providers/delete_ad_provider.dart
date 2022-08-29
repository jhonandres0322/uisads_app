


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_services.dart';

import '../constants/import_models.dart';

class DeleteAdProvider extends ChangeNotifier {


  Future<Response> deleteAd( String idAd ) async {
    final adService = AdService();
    return adService.deleteAd(idAd);
  }
}