import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_models.dart';

class SearchAdsProvider with ChangeNotifier {

  String _query = '';
  String _publisher = '';
  String _time = '';
  String _category = '';
  String _order = '';
  bool   _isLoading               = false;

  String get query => _query;
  set query(String value) {
    _query = value;
  }

  String get publisher => _publisher;
  set publisher(String value) {
    _publisher = value;
  }

  String get time => _time;
  set time(String value) {
    _time = value;
  }

  String get category => _category;
  set category(String value) {
    _category = value;
  }

  String get order => _order;
  set order(String value) {
    _order = value;
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SearchRequest organizeData( ) {
    return SearchRequest.fromJson({
      "query": _query,
      "publisher": _publisher,
      "time": _time,
      "category": _category,
      "order": _order
    });
  }


}
