import 'dart:developer';

import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/models/response_favorites_ads.dart';



// Provider para traer los favoritos
class FavoriteAdsProvider extends ListAdProvider {

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

  FavoriteAdsProvider() {
    getFavoriteAds();
  }

  ///Metodo para obtener los anuncios inicialmente
  getFavoriteAds() async {
    currentPage = 1;
    // Si esta cargando no entre aca
    if (isLoading) {return;}
    // Cargo los anuncios
    isLoading = true;
    log('getFavoritesAd + $_currentPage');
    final favoriteAdService = FavoritesService();
    final resp = await favoriteAdService.getFavoritesAds(_currentPage);
    log('Favoritesads: ${ads.length}');
    ads = [...ads, ...resp.favorites];
    // Terminamos de cargar
    isLoading = false;
    notifyListeners();
  }
  // Crear el metodo inicial de los anuncios y luego traer los anuncios por cada pagina
  void getFavoriteAdsNews() async {
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
    final favoriteAdService = FavoritesService();
    final resp = await favoriteAdService.getFavoritesAds(_currentPage);
    if (resp.favorites.isEmpty) {
      _currentPage--;
    }
    log('getFavoritesAds News of page $currentPage');
    log('Favoritesads: ${ads.length}');
    ads = [...ads, ...resp.favorites];
    isLoading = false;
    notifyListeners();
  }


}
