import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/models/category.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({Key? key, this.isGuest = false}) : super(key: key);

  final bool? isGuest;

  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: _categoryProvider.categories.length,
      itemBuilder: (context, index) {
        final categoria = _categoryProvider.categories[index];
        getCategoryIdByName(categoria);
        if (isGuest!) {
          log('$index ');
          return _CategoryButtonGuest(categoria: categoria);
        } else {
          return CategoriaButton(
            id: _categoryProvider.categories[index].id,
            icon: getIcon(_categoryProvider.categories[index].name),
            name: _categoryProvider.categories[index].name,
            enabled: _categoryProvider.categorySelect ==
                    _categoryProvider.categories[index].id
                ? true
                : false,
          );
        }
      },
    );
  }
}

/// Widget para el control de la categoria para un invitado en la aplicacion
class _CategoryButtonGuest extends StatelessWidget {
  const _CategoryButtonGuest({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final Category categoria;

  @override
  Widget build(BuildContext context) {
    var dialog = CustomAlertDialog(
      title: 'Posee permisos Limitados como Invitado ¿Desea Registrarse o Iniciar sesión?',
      icon: Icons.info,
      iconColor: const Color(0xff2F80ED),
      onPostivePressed: () {
        Navigator.of(context, rootNavigator: true).pop(true);
      },
      onNegativePressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
      circularBorderRadius: 10,
      positiveBtnText: 'Aceptar',
      positiveBtnColor:  AppColors.accept ,
      negativeBtnText: 'Cancelar',
      negativeBtnColor: AppColors.mainThirdContrast,
    );
    final Size size = MediaQuery.of(context).size;
    return FocusableActionDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        // width: 50,
        // height: 50,
        child: Column(
            children: [
              // Widget de categoria
              // Circulo del widget
              Container(
                width: 50,
                height: size.height * 0.05,
                child: IconButton(
                  icon: Icon(getIcon(categoria.name), size: size.height * 0.03),
                  color: categoria.name == 'Todos' ? AppColors.mainThirdContrast : AppColors.unSelected,
                  onPressed: () async {

                    if (categoria.name != 'Todos') {
                      bool confirmacion = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => dialog);
                      if (confirmacion) {
                        Navigator.pushReplacementNamed(context, 'home');
                      }
                    }
                  },
                ),
                decoration: BoxDecoration(
                  color: categoria.name == 'Todos' ? AppColors.titles : AppColors.mainThirdContrast,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        categoria.name == 'Todos' ? AppColors.titles : AppColors.unSelected,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                categoria.name,
                style: TextStyle(
                  color: categoria.name == 'Todos' ? AppColors.titles : AppColors.unSelected,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
