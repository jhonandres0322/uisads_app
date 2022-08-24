import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_providers.dart';

class MainPageProvider extends ListAdProvider {

  int _currentPage = 1;
  bool _isLoading = false;

  @override
  bool get isLoading => _isLoading;
  @override
  set isLoading(bool value) {
    _isLoading = value;
    // notifyListeners();
  }

  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  MainPageProvider() {
    log('Inicializando provider');
    getAds();
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
    final adService = AdService();
    final resp = await adService.getAds(_currentPage);
    final ResponseAds responseAds = ResponseAds.fromMap(resp);
    if (responseAds.ads.isEmpty) {
      _currentPage--;
    }
    log('getAds News of page $currentPage');
    log('ads: ${ads.length}');
    ads = [...ads, ...responseAds.ads];
    isLoading = false;
    notifyListeners();
  }
  ///Metodo para obtener los anuncios inicialmente
  getAds() async {
    currentPage = 1;
    // Si esta cargando no entre aca
    if (isLoading) {return;}
    // Cargo los anuncios
    isLoading = true;
    log('getAd + $_currentPage');
    final adService = AdService();
    final resp = await adService.getAds(_currentPage);
    final ResponseAds responseAds = ResponseAds.fromMap(resp);
    log('ads: ${ads.length}');
    ads = [...ads, ...responseAds.ads];
    // Terminamos de cargar
    isLoading = false;
    notifyListeners();
  }
  ///Metodo para obtener los anuncios por categoria
  getAdsByCategory(String categoria) async{
    if (isLoading) {return;}
    isLoading = true;
    log('getAdsByCategory + $_currentPage');
    final adService = AdService();
    final resp = await adService.getAdsByCategory(categoria);
    final ResponseAds responseAds = ResponseAds.fromMap(resp);
    log('ads: ${ads.length}');
    ads = [...ads, ...responseAds.ads];
    isLoading = false;
    notifyListeners();
  }
  ///Metodo para obtener los anuncios por categoria
  getAdsByCategoryNews(String categoria) async{
    if (isLoading) {return;}
    if (isRefresh) {
      currentPage = 1;
      ads = [];
      isRefresh = false;
    } else {
      currentPage++;
    }
    isLoading = true;
    final adService = AdService();
    final resp = await adService.getAdsByCategoryAndPage(categoria,currentPage.toString());
    final ResponseAds responseAds = ResponseAds.fromMap(resp);
    if (responseAds.ads.isEmpty) {
      _currentPage--;
    }
    log('getAds categories of page $currentPage');
    ads = [...ads, ...responseAds.ads];
    isLoading = false;
    notifyListeners();
  }
  ///Para limpiar los anuncios
  cleanAds() {
    ads = [];
    notifyListeners();
  }
}
