


import 'dart:developer';

import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AdService with HttpHandler {

  Future<Response> createAd( Ad ad ) async {
    final resp = await getPost('/ad', ad.toMap() );
    Response _response = Response.fromMap( resp );
    return _response;
  }


  Future<Map<String,dynamic>> getAds( int page ) async {
    final resp = await getGet('/ad/$page');
    return resp;
  }

}