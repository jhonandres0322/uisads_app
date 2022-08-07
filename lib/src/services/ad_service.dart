


import 'dart:convert';
import 'dart:developer';

import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/request_manage_calification.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/models/search_response.dart';
import 'package:uisads_app/src/models/upload.dart';
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


  Future<Map<String,dynamic>> getAds( int page ) async {
    final resp = await getGet('/ad/ads/$page');
    return resp;
  }

  Future<Ad> getAdById( String id ) async {
    List<Upload> images = [];
    final resp = await getGet('/ad/$id');
    for (var image in resp['ad']['images']) {
      Upload uploadPivot = Upload.fromMap( image );
      images.add( uploadPivot ); 
    }
    resp['ad']['images'] = images;
    Ad ad = Ad.fromMap( resp['ad'] );
    return ad;
  }

  Future<Response> manageRating( Map<String,dynamic> request ) async {
    RequestManageCalification _requestManageCalification = RequestManageCalification.fromMap( request );
    final resp = await getPost('/ad/rating', _requestManageCalification.toMap() );
    Response _response = Response.fromMap( resp);
    return _response;
  }

}
