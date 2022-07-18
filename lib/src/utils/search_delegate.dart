import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/dropdown_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';
import 'package:uisads_app/src/widgets/search_widget.dart';

class SearchDelegateUis extends SearchDelegate {
  
  // Mostrar el icono de limpiar busqueda, o hasta los filtros se pueden incluir en el searchBar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
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
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
      
    ];
  }
  // Mostrar el icono Leading de la barra
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
  // Mostrar resultados de la busqueda
  @override
  Widget buildResults(BuildContext context) {
    // Construccion de los resultados
    return Flexible(
        // flex: 1,
        child: ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CardTable(),
        );
      },
    ));
  }
  // Mostrar las sugerencias de la busqueda
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}


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