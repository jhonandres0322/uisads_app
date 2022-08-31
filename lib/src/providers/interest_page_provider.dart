import 'package:flutter/material.dart';


/// Provider para los intereses
class InterestPageProvider with  ChangeNotifier {

  String _interes = '';
  final _formKey = LabeledGlobalKey<FormState>('interest_form');
  GlobalKey<FormState> get formKey => _formKey;
  List<String> _interests = [];

  String get interes => _interes;
  set interes(String value) {
    _interes = value;
    notifyListeners();
  }
  List<String> get interests => _interests;
  set interests( List<String> value ) {
    _interests = value;
    notifyListeners();
  }
  // Metodo para agregar un interes
  void addInterest( String value ) {
    _interests.add(value);
    notifyListeners();
  }
  // Metodo para eliminar un interes
  void removeInterest( String value ) {
    _interests.remove(value);
    notifyListeners();
  }
  // Metodo para validar el interes
  String? validateInterest( String? value ) {
    if (value!.isEmpty) {
      return 'Campo Requerido';
    }
    return '';
  }
  // Metodo para limpiar la lista de intereses
  void cleanInterests() {
    _interests.clear();
    notifyListeners();
  }
}