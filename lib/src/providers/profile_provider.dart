import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_providers.dart';

class ProfileProvider extends ListAdProvider {
  String   _uid             = '';
  Upload   photo            = Upload();
  String   name             = '';
  String   description      = '';
  String   email            = '';
  String   city             = '';
  String   cellphone        = '';
  String   nroPublications  = '';
  String   nroScore         = '';
  String   nroCalification  = '';

  // Manejo de los anuncios en el perfil
  int      _currentPage      = 0;
  String   _sort             = 'date';

  String get uid => _uid;
  set uid( String value ) {
    _uid = value;
    currentPage = 0;
    notifyListeners();
  }

  String get sort => _sort;
  set sort( String value ) {
    _sort = value;
    notifyListeners();
  }

  int get currentPage => _currentPage;
  set currentPage( int value ) {
    _currentPage = value;
    ads = [];
    page = 0;
    isLoading = true;
    isRefresh = true;
    getAdsByPublisher();
    notifyListeners();
  }

  void saveInfoProfile( Profile profile) {
    photo = profile.image;
    name = profile.name;
    description = profile.description;
    cellphone =  profile.cellphone;
    email = profile.email;
    city = profile.city;
  }

  getAdsByPublisher() async {
    if( isLoading ) {
      final adService = AdService();
      if( isRefresh ) {
        page = 1;
        ads = [];
        isRefresh = false;
      } else {
        page++;
      }
      final resp = await adService.getAdsByPublisher(uid, sort, page);
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
