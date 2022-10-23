import 'package:shared_preferences/shared_preferences.dart';
import 'package:uisads_app/src/constants/import_models.dart';

class Preferences {

  SharedPreferences? _prefs;

  static String token = '';
  static String uid   = '';
  static String email = '';
  static String name  = '';
  static Upload image = Upload();
  static bool isNotify = false;
  

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void clearInfoLogout() {
    token = '';
    uid   = '';
    email = '';
    name  = '';
    image = Upload();
    isNotify = false;
  }

  static void saveInfoLogin( Map<String,dynamic> infoProfile ) {
    token = infoProfile["token"];
    uid   = infoProfile["uid"];
    email = infoProfile["email"];
    name  = infoProfile["name"];
    image = infoProfile["image"];
    isNotify = infoProfile["isNotify"];
  }

  static void updateInfo( Profile profile ) {
    email = profile.email;
    name  = profile.name;
    if ( profile.image.content.isNotEmpty ) {
      image = profile.image;
    }
  }
  
}