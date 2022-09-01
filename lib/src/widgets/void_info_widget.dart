import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';

/// Widget que muestra una lista de categorias es vacia
class VoidInfoWidget extends StatelessWidget {
  const VoidInfoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
        height: 200,
        child: Column(
          children: [
            Container(
              child: const Icon(
                CustomUisIcons.photo_outline,
                size: 100,
                color: AppColors.subtitles,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No se ha encontrado ningun anuncio asociado a la categoria seleccionada',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.subtitles,
              ),
            )
          ],
        ),
      ),
    );
  }
}