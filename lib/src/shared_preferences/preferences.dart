import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _prefs;

  static String _token = '';
  static String _profile = '';
  static String _user = '';

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get token {
    return _prefs?.getString('token') ?? _token;
  }

  set token( String token ) {
    _token = token;
    _prefs?.setString('token', token); 
  }

  String get profile {
    return _prefs?.getString('profile') ?? _profile;
  }

  set profile( String profile ) {
    _profile = profile;
    _prefs?.setString('profile', profile);
  }
}