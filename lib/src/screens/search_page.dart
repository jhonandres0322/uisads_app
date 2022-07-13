import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/categoria_card.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  // TODO: Implementar en la bottomNavigationBar que este seleccionado el boton de buscar
  // TODO: Implementar el draggableBottomSheet para que se pueda buscar por categoria
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainThirdContrast,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.subtitles,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(CustomUisIcons.search_right),
            color: AppColors.subtitles,
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigatonBarUisAds(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
            // TODO: Lista de categorias
            Container(
                width: double.infinity,
                // color: Colors.yellow,
                height: 50,
                child: _ListaCategorias()
            ),
            SizedBox(
              height: 10,
            ),
            // TODO: Barra de busqueda y icono filtro
            Container(),
            // TODO: Placeholder para los anuncios ojala sea animado
            Container(),
            CardTable(),
            CardTable(),
            CardTable(),
            CardTable(),
            CardTable(),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorias = categoriasData;
    // TODO: Agregar la lista de categorias
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoriaCard(
          icono: categorias[index].icono,
          nombre: categorias[index].nombre,
        );
      },
    );
  }
}
