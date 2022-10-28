import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class NotificationPageProvider extends ListAdProvider {
  bool _estadoNotificaciones = Preferences.isNotify;
  // Propiedad para manejar la pagina actual de anuncios favoritos
  int _currentPage      = 0;
  bool _isLoading = false;

  @override
  bool get isLoading => _isLoading;
  @override
  set isLoading(bool value) {
    _isLoading = value;
  }

  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  NotificationPageProvider() {
    getNotificationAds();
  }

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

  ///Metodo para obtener los anuncios inicialmente
  getNotificationAds() async {
    currentPage = 1;
    // Si esta cargando no entre aca
    if (isLoading) {return;}
    // Cargo los anuncios
    isLoading = true;
    log('getFavoritesAd + $_currentPage');
    final notificationAdService = NotificationService();
    final resp = await notificationAdService.getFavoritesAds(_currentPage);
    log('Favoritesads: ${ads.length}');
    ads = [...ads, ...resp.notifications];
    // Terminamos de cargar
    isLoading = false;
    notifyListeners();
  }
  // Crear el metodo inicial de los anuncios y luego traer los anuncios por cada pagina
  void getNotificationAdsNews() async {
    if (isLoading) {return;}
    if (isRefresh) {
      currentPage = 1;
      ads = [];
      isRefresh = false;
    } else {
      currentPage++;
    }
    // Cargamos nuevos anuncios
    isLoading = true;
    final notificationAdService = NotificationService();
    final resp = await notificationAdService.getFavoritesAds(_currentPage);
    if (resp.notifications.isEmpty) {
      _currentPage--;
    }
    log('getFavoritesAds News of page $currentPage');
    log('Favoritesads: ${ads.length}');
    ads = [...ads, ...resp.notifications];
    isLoading = false;
    notifyListeners();
  }

}
