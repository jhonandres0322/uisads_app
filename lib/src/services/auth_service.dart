import 'package:flutter/cupertino.dart';
import 'package:uisads_app/src/utils/http_handler.dart';



class AuthService with HttpHandler {

  Future<dynamic> loginUser() async {
    debugPrint("entrando a login service");
    Map<String, dynamic> request = {
      "email": "jhonandres0322gmail.com",
      "password": "123456"
    };
    final resp = await getPost('/auth/login', request);
    debugPrint(" resp --> $resp");
    return resp;
  }

}