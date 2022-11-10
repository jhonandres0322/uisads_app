import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

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

  // Metodo para mostrar un resultado luego de una peticion HTTP
  static void mostrarResultadoError(Response response, BuildContext context) {
    if (response.error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(showAlertCustom(response.message, response.error));
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
      ScaffoldMessenger.of(context)
          .showSnackBar(showAlertCustom(response.message, response.error));
    }
  }

  // Metodo para mostrar un modal de confirmacion con un texto definido
  static CustomAlertDialog mostrarDialogo(
      BuildContext context, String mensajeDialogo) {
    return CustomAlertDialog(
      title: mensajeDialogo,
      icon: Icons.check_circle,
      iconColor: AppColors.accept,
      onPostivePressed: () {
        Navigator.of(context, rootNavigator: true).pop(true);
      },
      onNegativePressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
      circularBorderRadius: 10,
      positiveBtnText: 'Aceptar',
      positiveBtnColor: AppColors.primary,
      negativeBtnText: 'Cancelar',
      negativeBtnColor: AppColors.mainThirdContrast,
    );
  }
}
