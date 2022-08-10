import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
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
    ScrollController _scrollController = ScrollController();
    final _adService = new AdService();

    if (query.trim().length == 0) {
      return Center(
        child: Text(
          'No se encontraron resultados',
          style: TextStyle(
            color: AppColors.subtitles,
            fontSize: 20,
          ),
        ),
      );
    }
    return FutureBuilder(
        future: _adService.searchAds(query),
        builder: (BuildContext context, AsyncSnapshot<List<Ad>> snapshot) {
          if (snapshot.hasData) {
            List<Ad> ads = snapshot.data!;
            if (ads.length == 0) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 200,
                  child: Column(
                    children: [
                      Container(
                        child: Icon(
                          Icons.warning,
                          size: 100,
                          color: AppColors.subtitles,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No se ha encontrado ningun anuncio con los criterios especificados',
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
            } else {
              // Desplegamos la lista de anuncios
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: GridView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    physics: const BouncingScrollPhysics(),
                    itemCount: ads.length,
                    itemBuilder: (context, index) {
                      return AdCard(
                        title: ads[index].title,
                        mainPage: ads[index].mainPage,
                        id: ads[index].id,
                      );
                      return Container();
                    }),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    // Aqui realizar la busqueda de los resultados
    // return Center(
    //   child: Text(
    //     'Resultados de la busqueda: $query',
    //     style: TextStyle(
    //       color: AppColors.subtitles,
    //       fontSize: 20,
    //     ),
    //   ),
    // );
    // Construccion de los resultados
    // return Flexible(
    //     // flex: 1,
    //     child: ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //       child: Container(),
    //     );
    //   },
    // ));
  }

  // Mostrar las sugerencias de la busqueda
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: Center(
            child: Container(
          height: 200,
          child: Column(
            children: [
              Container(
                child: Icon(
                  CustomUisIcons.advertising,
                  size: 100,
                  color: AppColors.subtitles,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No se ha realizado ninguna búsqueda',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.subtitles,
                ),
              )
            ],
          ),
        )),
      );
    }
    return Container();
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

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
          InputCustom(
              labelText: 'Por Fecha de Publicacion', input: dropdownFecha),
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
