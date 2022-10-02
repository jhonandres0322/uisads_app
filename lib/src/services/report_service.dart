import 'dart:developer';

import 'package:uisads_app/src/constants/import_utils.dart';
import '../constants/import_models.dart';

class ReportService with HttpHandler {
  
  // void manageReport( String idAd ) async {
  Future<Response> manageReport( String idAd ) async {
    Map<String,dynamic> response = await getPost('/report', {
        'ad': idAd 
    });
    log('response service --> $response');
    return Response.fromMap( response );
  }
}