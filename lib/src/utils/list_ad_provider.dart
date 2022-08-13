

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';

class ListAdProvider with ChangeNotifier {
  
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
    notifyListeners();
  }

  int get page => _page;
  set page( int value ) {
    _page = value;
    notifyListeners();
  }
}