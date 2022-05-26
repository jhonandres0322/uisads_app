import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:uisads_app/src/models/user_request.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AuthService extends ChangeNotifier with HttpHandler {

  
  Future<dynamic> loginUser(Map<String, dynamic> user) async {
    log("entrando a login service");
    UserRequest userRequest = UserRequest.fromJson(user);
    log(" userRequest --> ${userRequest.toString()} ");
    final resp = await getPost('/auth/login', userRequest.toJson());
    log(" resp --> $resp");
    return resp;
  }

  Future<dynamic> registerUser() async {}
}
