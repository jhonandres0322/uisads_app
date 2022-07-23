

import 'dart:developer';

import 'package:uisads_app/src/models/city.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class CityService with HttpHandler {

  Future<List<City>> getCities() async {
    final resp = await getGet('/city');
    final List<City> cities = [];
    final List<dynamic> respCities = resp['cities'] ;
    for (var element in respCities) { 
      cities.add( City.fromMap( element ));
    }
    return cities;
  }

}