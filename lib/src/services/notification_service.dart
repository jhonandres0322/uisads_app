
import 'package:uisads_app/src/constants/import_models.dart';

import '../constants/import_utils.dart';

/**
 * InterestService Servicio para cargar, eliminar y guardar intereses
 */
class NotificationService with HttpHandler {
  // Servicio para cargar los intereses
  Future<Map<String, dynamic>> getNotifications() async {
    final resp = await getGet('/notification');
    return resp;
  }

  // Servicio para activar o desactivar las notificaciones
  Future<Response> activarDesactivarNotificaciones(String estadoNotificacion) async {
    final resp = await getPost('/notification', {
      'choice': estadoNotificacion
    });
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
