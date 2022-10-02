import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_services.dart';

import '../constants/import_models.dart';


class ReportProvider extends ChangeNotifier {

  bool _isReported = false;

  bool get isReported => _isReported;
  void set isReported( bool value ) {
    _isReported = value;
    notifyListeners();
  }


  manageReport( String idAd ) {
    ReportService _reportService = ReportService();
    Future<Response> response = _reportService.manageReport(idAd);
    log('response --> ${response}');
    _isReported = !isReported;
  }

}