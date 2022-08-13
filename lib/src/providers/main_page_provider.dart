import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
  

class MainPageProvider extends ListAdProvider {


  MainPageProvider(){
    getAds();
  }

  getAds() async {
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