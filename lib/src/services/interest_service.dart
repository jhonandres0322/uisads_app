import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';

import '../constants/import_utils.dart';

/**
 * InterestService Servicio para cargar, eliminar y guardar intereses
 */
class InterestService with HttpHandler {
  // Servicio para cargar los intereses
  Future<Map<String, dynamic>> getInterests() async {
    final resp = await getGet('/interest');
    return resp;
  }

  // Servicio para guardar los intereses
  Future<Response> saveInterests(RequestInterest request) async {
    final resp = await getPostEncode('/interest', request.toJson());
    Response _response = Response.fromMap(resp);
    return _response;
  }
  // Metodo para eliminar un interes por id
  // Future<Response> deleteInterest( String id ) async {
  //   final resp = await getDelete('/interest/$id');
  //   Response _response = Response.fromMap( resp );
  //   return _response;
  // }

}
