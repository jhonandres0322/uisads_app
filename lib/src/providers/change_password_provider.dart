

import 'package:flutter/material.dart';
import 'package:uisads_app/src/models/request_change_password.dart';

class ChangePasswordProvider with ChangeNotifier {

  String oldPassword           = '';
  String newPassword           = '';
  String confirmNewPassword    = '';
  
  RequestChangePassword getData() {
    return RequestChangePassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}