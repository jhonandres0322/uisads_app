


import 'dart:developer';

import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AdService with HttpHandler {

  Future<Response> createAd( Ad ad ) async {
    log('entrando al servicio');
    final resp = await getPost('/ad', ad.toMap() );
    log(' resp --> $resp');
    Response _response = Response.fromMap( resp );
    return _response;
  }


}