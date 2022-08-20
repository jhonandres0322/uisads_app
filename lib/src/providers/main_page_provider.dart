import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
  

class MainPageProvider extends ListAdProvider {


  MainPageProvider(){
    log('Inicializando provider');
    getAds();
  }

  @override
  set isLoading( bool value ) {
    log('cambiando isLoading');
    isLoading = value;
    getAds();
    notifyListeners();
  }

  getAds() async {
    log('getAd');
    if( isLoading ) {
      final adService = AdService();
      if( isRefresh ) {
        page = 1;
        ads = [];
        isRefresh = false;
      } else {
        page++;
      }
      final resp = await adService.getAds(page);
      final ResponseAds responseAds = ResponseAds.fromMap(resp);
      if( responseAds.ads.isEmpty ) {
        page--;
      }
      ads = [ ...ads, ...responseAds.ads ];
      isLoading = false;
      notifyListeners();
    }
  }

}