import 'dart:developer';

import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

class CityService with HttpHandler {

  Future<List<City>> getCities() async {
    final resp = await getGet('/city');
    final List<dynamic> respCities = resp['cities'];
    final List<City> cities = respCities.map((e) => City.fromMap( e ) ).toList();
    return cities;
  }

  Future<City> getCityId( String id ) async { 
    final resp = await getGet('/city/$id');
    final City city = City.fromMap( resp['city'] );
    return city;
  }
}