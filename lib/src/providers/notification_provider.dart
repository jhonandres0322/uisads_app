import 'package:flutter/material.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class NotificationPageProvider with ChangeNotifier {
  bool _estadoNotificaciones = Preferences.isNotify;

  // Setters y getters
  bool get estadoNotificaciones => _estadoNotificaciones;
  set estadoNotificaciones(bool value) {
    _estadoNotificaciones = value;
    Preferences.isNotify = _estadoNotificaciones;
  }

  // Metodo para cambiar el estado de las notificaciones
  void changeStateNotification() {
    _estadoNotificaciones = !_estadoNotificaciones;
    Preferences.isNotify = _estadoNotificaciones;
    notifyListeners();
  }

}
