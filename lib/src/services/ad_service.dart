import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

/// Esta clase es la responsable del servicio de anuncios, asi como tambien su busqueda.
class AdService with HttpHandler {
  Future<Response> createAd(Ad ad) async {
    final resp = await getPost('/ad', ad.toMap());
    Response _response = Response.fromMap(resp);
    return _response;
  }

  // Servicio de busqueda de anuncios en base a un query.
  Future<List<Ad>> searchAds(SearchRequest searchRequest) async {
    final resp = await getPost('/ad/search/',searchRequest.toJson());
    SearchResponse _searchResponse = SearchResponse.fromMap(resp);
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

  Future<Map<String,dynamic>> getAdsByPublisher( String publisher, String orden, int page ) async {
    final resp = await getGet('/ad/publisher/$publisher/$orden/$page');
    return resp;
  }

  Future<Map<String,dynamic>> getAdsByCategory( String category ) async {
    final resp = await getGet('/ad/category/$category');
    return resp;
  }

  Future<Response> deleteAd( String idAd ) async {
    final resp = await getDelete('/ad/$idAd');
    return Response.fromMap( resp );
  }

  Future<Response> editAd( String idAd, Ad adEdit ) async {
    final resp = await getPut('/ad/$idAd', adEdit.toMap() );
    final Response response = Response.fromMap( resp ); 
    return response;
  }
}
