import 'package:uisads_app/src/constants/import_utils.dart';




class HistorialService with HttpHandler {

  // Metodo para obtener los favoritos paginados
  Future<Map<String,dynamic>> getHistorialAds( int page ) async {
    final resp = await getGet('/historial/$page');
    return resp;
  }
}
