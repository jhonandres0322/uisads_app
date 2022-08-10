
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';


class MainPageProvider extends ChangeNotifier {


  List<Ad> ads = [];
  int _page = 0;
  bool _isLoading = true;


  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  MainPageProvider(){
    log('Inicializando provider');
    getAds();
  }

  addAd( Ad ad ) {
    ads.insert(0, ad);
    notifyListeners();
  }

  getAds() async {
    if( isLoading ) {
      final adService = AdService();
      _page++;
      log('page --> $_page');
      final resp = await adService.getAds(_page);
      final ResponseAds responseAds = ResponseAds.fromMap(resp);
      if( responseAds.ads.isEmpty ) {
        _page--;
      }
      ads = [ ...ads, ...responseAds.ads ];
      isLoading = false;
      notifyListeners();
    }
  }

}