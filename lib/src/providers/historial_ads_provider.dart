// Provider para traer los favoritos
import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';

// Provider para traer los anuncios del historial
class HistoryAdsProvider extends ListAdProvider {

  // Propiedad para manejar la pagina actual de los anuncios del historial
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
  // Metodo para obtener los anuncios inicialmente
  getHistoryAds() async {
    currentPage = 1;
    // Si esta cargando no entre aca
    if (isLoading) {return;}
    // Cargo los anuncios
    isLoading = true;
    log('getHistoryAd + $_currentPage');
    final historialAdService = HistorialService();
    final resp = await historialAdService.getHistorialAds(_currentPage);
    final ResponseHistorialAds responseAds = ResponseHistorialAds.fromMap(resp);
    log('HistoryAds: ${ads.length}');
    ads = [...ads, ...responseAds.historial];
    // Terminamos de cargar
    isLoading = false;
    notifyListeners();
  }
  // Crear el metodo inicial de los anuncios y luego traer los anuncios por cada pagina
  void getAdsNews() async {
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
    final historialAdService = HistorialService();
    final resp = await historialAdService.getHistorialAds(_currentPage);
    final ResponseHistorialAds responseAds = ResponseHistorialAds.fromMap(resp);
    ads = [...ads, ...responseAds.historial];
    // Terminamos de cargar
    isLoading = false;
    notifyListeners();
  }

}
