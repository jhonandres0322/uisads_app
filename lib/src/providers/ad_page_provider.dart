import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';

class AdPageProvider with ChangeNotifier {

  final SwiperController _swiperController = SwiperController();
  Ad ad = Ad.fromMap({});

  SwiperController get swiperController => _swiperController;

  changeIndex( int index ) {
    _swiperController.index = index ;
    notifyListeners();
  }

  getAd( String idAd ) async {
    final adService = AdService();
    ad = await adService.getAdById( idAd );
    notifyListeners();
  }


  clearData( ) {
    ad = Ad.fromMap({});
    notifyListeners();
  }

}