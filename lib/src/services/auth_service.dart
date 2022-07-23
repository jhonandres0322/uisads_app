import 'dart:developer';

import 'package:uisads_app/src/models/login_request.dart';
import 'package:uisads_app/src/models/login_response.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/user_register.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AuthService with HttpHandler {
  
  Future<LoginResponse> loginUser( LoginRequest user) async {
    final resp = await getPost('/auth/login', user.toMap() );
    LoginResponse loginResponse = LoginResponse.fromMap( resp );
    return loginResponse;
  }

  Future<Map<String,dynamic>> registerUser( Map<String, dynamic> user ) async {
    UserRegister userRegister = UserRegister.fromJson(user);
    final resp = await getPost('/auth/register', userRegister.toJson());
    return resp;
  }

  Future<Profile> getProfile( String idProfile ) async {
    final resp = await getGet('/profile/$idProfile');
    resp['profile']['email'] = resp['email'];
    Profile profile = Profile.fromMap( resp['profile'] );
    return profile;
  }

  Future<Map<String,dynamic>> editProfile( String idProfile, Map<String,dynamic> profile ) async {
    final resp = await getPut('/profile/$idProfile', profile);
    return resp;
  }

  Future<dynamic> getCities() async {
    final resp = await getGet('/city');
    return resp;
  }
}
