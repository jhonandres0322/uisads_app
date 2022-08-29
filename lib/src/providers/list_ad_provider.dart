

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

abstract class ListAdProvider extends ChangeNotifier {
  
  List<Ad> ads    = [];
  int _page       = 0;
  bool _isLoading = true;
  bool _isRefresh = false;

  bool get isRefresh => _isRefresh;
  set isRefresh( bool value ) {
    _isRefresh = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    // notifyListeners();
  }

  int get page => _page;
  set page( int value ) {
    _page = value;
    notifyListeners();
  }

  bool validateManage( BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if( currentRoute == 'profile') {
      if( profileProvider.uid == Preferences.uid ) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}