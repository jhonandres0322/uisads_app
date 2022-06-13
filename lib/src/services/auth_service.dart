import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:uisads_app/src/models/user_request.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AuthService extends ChangeNotifier with HttpHandler {
  Future<Map<String,dynamic>> loginUser(Map<String, dynamic> user) async {
    UserRequest userRequest = UserRequest.fromJson(user);
    final resp = await getPost('/auth/login', userRequest.toJson());
    return resp;
  }

  Future<dynamic> registerUser() async {}
}
