
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/response_ads.dart';
import 'package:uisads_app/src/services/ad_service.dart';

class MainPageProvider with ChangeNotifier {


  List<Ad> ads = [];
  final AdService _adService = AdService();
  int _page = 0;




  MainPageProvider(){
    log('Inicializando provider');
    getAds();
  }



  getAds() async {
    _page++;
    final resp = await _adService.getAds(_page);
    final ResponseAds responseAds = ResponseAds.fromMap(resp);
    ads = [ ...ads, ...responseAds.ads ];
    log('ads --> $ads');
    notifyListeners();
  }

}