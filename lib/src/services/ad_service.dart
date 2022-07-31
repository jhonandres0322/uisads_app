import 'dart:developer';

import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/models/search_response.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

/// Esta clase es la responsable del servicio de anuncios, asi como tambien su busqueda.
class AdService with HttpHandler {
  Future<Response> createAd(Ad ad) async {
    final resp = await getPost('/ad', ad.toMap());
    Response _response = Response.fromMap(resp);
    return _response;
  }

  // Servicio de busqueda de anuncios en base a un query.
  Future<List<Ad>> searchAds(String search) async {
    final resp = await getGet('/ad/search/$search');
    print(resp);
    SearchResponse _searchResponse = SearchResponse.fromMap(resp);
    //TODO: Tomar los ids de las imagenes y hacer una peticion para obtener la imagen, introduciendo el id en el mapa de imagenes.
    return _searchResponse.ads;
  }
}
