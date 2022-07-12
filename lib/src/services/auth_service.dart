import 'dart:developer';

import 'package:uisads_app/src/models/user_login.dart';
import 'package:uisads_app/src/models/user_register.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AuthService with HttpHandler {
  
  Future<Map<String,dynamic>> loginUser(Map<String, dynamic> user) async {
    UserLogin userLogin = UserLogin.fromJson(user);
    final resp = await getPost('/auth/login', userLogin.toJson());
    return resp;
  }

  Future<Map<String,dynamic>> registerUser( Map<String, dynamic> user ) async {
    UserRegister userRegister = UserRegister.fromJson(user);
    final resp = await getPost('/auth/register', userRegister.toJson());
    return resp;
  }

  Future<dynamic> getCities() async {
    final resp = await getGet('/city');
    return resp;
  }
}
