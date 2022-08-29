

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';

class ChangePasswordProvider with ChangeNotifier {

  String oldPassword           = '';
  String newPassword           = '';
  String confirmNewPassword    = '';
  
  RequestChangePassword getData() {
    return RequestChangePassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}