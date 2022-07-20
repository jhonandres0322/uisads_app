import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/utils/search_delegate.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/bottom_sheet.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/categoria_card.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';
import 'package:uisads_app/src/widgets/dropdown_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';
import 'package:uisads_app/src/widgets/search_widget.dart';

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
            onPressed: () {
              showSearch(
                context: context, 
                delegate: SearchDelegateUis()
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigatonBarUisAds(),
      body: Container(
        child: _BodyElements(),
      ),
    );
  }
}

class _BodyElements extends StatelessWidget {
  const _BodyElements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 10,
        ),
        // Lista de categorias el height afecta el tamaño de las categorias internas
        Container(
            width: double.infinity,
            // color: Colors.yellow,
            height: 45,
            child: _ListaCategorias()),
        SizedBox(
          height: 10,
        ),
        // SearchWidget(),
        // TODO: Placeholder para los anuncios ojala sea animado
        Flexible(
            // flex: 1,
            child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // child: CardTable(),
            );
          },
        )),
      ],
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
