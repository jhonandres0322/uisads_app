import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';




class FavoritesService with HttpHandler {

  // Metodo para obtener los favoritos paginados
  Future<ResponseFavoriteAds> getFavoritesAds( int page ) async {
    final resp = await getGet('/favorite/favorite-ad/$page');
    return ResponseFavoriteAds.fromMap(resp);
  }
  // Metodo para guardar un anuncio favorito
  Future<Response> saveFavoriteAd( String adId ) async {
    final resp = await getPost('/favorite/favorite-ad',{ 'ad': adId });
    Response _response = Response.fromMap( resp );
    return _response;
  }
  // Metodo para eliminar un anuncio favorito
  Future<Response> deleteFavoriteAd( String adId ) async {
    final resp = await getDelete('/favorite/favorite-ad/$adId');
    Response _response = Response.fromMap( resp );
    return _response;
  }
}
