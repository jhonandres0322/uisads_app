import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/categoria_card.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';
import 'package:uisads_app/src/widgets/dropdown_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

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
        // TODO: Barra de busqueda y icono filtro
        _SearchWidget(),
        // TODO: Placeholder para los anuncios ojala sea animado
        Flexible(
            // flex: 1,
            child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CardTable(),
            );
          },
        )),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Widget inputEmail = TextField(
      onChanged: (value) {},
      controller: TextEditingController(),
      // autofocus: false,
      keyboardType: TextInputType.text,
      decoration: decorationInputCustom(CustomUisIcons.search_right,
          '¿Qué estas buscando?', AppColors.titles, true),
    );

    return Container(
      height: size.height * 0.06,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: size.width * 0.05),
              width: size.width * 0.75,
              child: inputEmail),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(CustomUisIcons.filter),
            color: AppColors.subtitles,
            onPressed: () => showModalBottomSheet(
              context: context,
              // isScrollControlled: true ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => _BottomSheet(),
            ),
            // iconSize: size.height * 0.06,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 10),
    //   height: 60,
    //   color: Colors.yellow,
    // );
  }
}

// Construccion del widget del bottomSheet
class _BottomSheet extends StatelessWidget {
  const _BottomSheet({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Creacion de los DropdownCustoms, quedaria pendiente revisar si se optimiza de una mejor forma
    final Widget dropdownRelevancia = DropdownCustom(
      options: optionsRelevance,
      inputDecoration: decorationDropdownCustom('Seleccione Relevancia'),
      onChanged: (value) {
        print(value);
      },
    );
    final Widget dropdownFecha = DropdownCustom(
      options: optionsDate,
      inputDecoration: decorationDropdownCustom('Seleccione una fecha'),
      onChanged: (value) {
        print(value);
      },
    );
    final Widget dropdownCategoria = DropdownCustom(
      options: optionsCategory,
      inputDecoration: decorationDropdownCustom('Seleccione una categoria'),
      onChanged: (value) {
        print(value);
      },
    );
    // Puedo cambiar el SingleChildScrollView por un ListView y eliminar la columna
    return SingleChildScrollView(
      child: Column(
        children: [
          InputCustom(labelText: 'Por Relevancia', input: dropdownRelevancia),
          InputCustom(labelText: 'Por Fecha de Publicacion', input: dropdownFecha),
          InputCustom(labelText: 'Por Categoria', input: dropdownCategoria),
          SizedBox(
            height: 25,
          ),
          _ButtonFilter(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class _ButtonFilter extends StatelessWidget {
  const _ButtonFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.80,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Buscar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto')),
          style: ElevatedButton.styleFrom(
              primary: AppColors.third,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
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
