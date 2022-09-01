import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

class UtilsOperations {
  /// Metodo para contactar al usuario enviado
  static Color compararCategoryId(
      List<Categoria> categoriasData, String idCategoria) {
    Color colorEncontrado = Colors.black54;

    for (var element in categoriasData) {
      if (element.id == idCategoria) {
        colorEncontrado = element.color!;
      }
    }
    return colorEncontrado;
  }
}
