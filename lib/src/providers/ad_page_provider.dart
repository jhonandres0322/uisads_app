import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class AdPageProvider with ChangeNotifier {

  final SwiperController _swiperController = SwiperController();

  SwiperController get swiperController => _swiperController;

  changeIndex( int index ) {
    _swiperController.index = index ;
    notifyListeners();
  }

}