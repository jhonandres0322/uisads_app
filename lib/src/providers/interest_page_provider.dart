import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';

/// Provider para los intereses
class InterestPageProvider with ChangeNotifier {
  String _interes = '';
  final _formKey = LabeledGlobalKey<FormState>('interest_form');
  GlobalKey<FormState> get formKey => _formKey;
  List<String> _interests = [];

  InterestPageProvider() {
    log('InterestPageProvider iniciando');
    // getInterests();
  }
  String get interes => _interes;
  set interes(String value) {
    _interes = value;
    notifyListeners();
  }

  List<String> get interests => _interests;
  set interests(List<String> value) {
    _interests = value;
    notifyListeners();
  }

  // Metodo para agregar un interes
  void addInterest(String value) {
    _interests.add(value);
    notifyListeners();
  }

  // Metodo para eliminar un interes
  void removeInterest(String value) {
    _interests.remove(value);
    notifyListeners();
  }

  // Metodo para validar el interes
  String? validateInterest(String? value) {
    if (value!.isEmpty) {
      return 'Campo Requerido';
    }
    return '';
  }
  // Agrupar data en request
  RequestInterest handlerData() {
    return RequestInterest.fromJson({
      'interests': interests,
    });
  }
  // Metodo para limpiar la lista de intereses
  void cleanInterests() {
    _interests = [];
  }

  // metodo obtener intereses del usuario
  Future<Map<String, dynamic>> getInterests() async {
    // Cargar la informacion de los intereses
    final interestService = InterestService();
    final resp = await interestService.getInterests();
    // final ResponseInterest interesesTemp = ResponseInterest.fromJson(resp);
    return resp;
  }

}
