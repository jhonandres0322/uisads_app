import 'package:uisads_app/src/constants/import_utils.dart';




class FavoritesService with HttpHandler {

  // Metodo para obtener los favoritos paginados
  Future<Map<String,dynamic>> getFavoritesAds( int page ) async {
    final resp = await getGet('/favorite/favorite-ad/$page');
    return resp;
  }
}
