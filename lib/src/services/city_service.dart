import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

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

  Future<City> getCityId( String id ) async { 
    final resp = await getGet('/city/$id');
    final City city = City.fromMap( resp['city'] );
    return city;
  }
}