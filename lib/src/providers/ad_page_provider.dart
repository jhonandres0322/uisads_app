import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';

class AdPageProvider with ChangeNotifier {

  final SwiperController _swiperController = SwiperController();
  String _phone = '';
  Ad ad = Ad.fromMap({});
  String _choiceSelected = '';
  String _favoriteSelection = '';

  


  SwiperController get swiperController => _swiperController;

   // Gets y sets de ChoiceSelected
  String get favoriteSelection => _favoriteSelection;
  set favoriteSelection(String value) {
    _favoriteSelection = value;
    notifyListeners();
  }
  // Propiedad temporal para el telefono de contacto
  String get phone => _phone;
  set phone( String value ) {
    _phone = value;
  }

  changeIndex( int index ) {
    _swiperController.index = index ;
    notifyListeners();
  }

  getAd( String idAd ) async {
    final adService = AdService();
    ad = await adService.getAdById( idAd );
    notifyListeners();
  }

  // Gets y sets de ChoiceSelected
  String get choice => _choiceSelected;
  set choice(String value) {
    _choiceSelected = value;
    // notifyListeners();
  }

  clearData( ) {
    ad = Ad.fromMap({});
    notifyListeners();
  }

}