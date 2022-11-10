import 'package:uisads_app/src/constants/import_models.dart';

import '../constants/import_utils.dart';

/**
 * InterestService Servicio para cargar, eliminar y guardar intereses
 */
class NotificationService with HttpHandler {
  // Servicio para cargar las notificaciones que son como anuncios
  // Metodo para obtener los favoritos paginados
  Future<ResponseNotificationAds> getFavoritesAds(int page) async {
    final resp = await getGet('/notification/$page');
    return ResponseNotificationAds.fromMap(resp);
  }

  // Revisar notificaciones nuevas
  Future<Response> checkNewNotifications(String token) async {
    final resp = await getPostNotifications('/notification/validate', {}, token);
    Response _response = Response.fromMap(resp);
    return _response;
  }

  // Servicio para activar o desactivar las notificaciones
  Future<Response> activarDesactivarNotificaciones(
      String estadoNotificacion) async {
    final resp = await getPost('/notification', {'choice': estadoNotificacion});
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
