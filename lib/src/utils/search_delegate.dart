import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class SearchDelegateUis extends SearchDelegate {
  // Mostrar el icono de limpiar busqueda, o hasta los filtros se pueden incluir en el searchBar
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(CustomUisIcons.filter),
        color: AppColors.subtitles,
        onPressed: () => showModalBottomSheet(
          context: context,
          // isScrollControlled: true ,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) => const _BottomSheet(),
        ),
        // iconSize: size.height * 0.06,
      ),
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  // Mostrar el icono Leading de la barra
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
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
    final searchProvider = Provider.of<SearchAdsProvider>(context);

    if (query.trim().length == 0) {
      return const Center(
        child: Text(
          'No se encontraron resultados',
          style: TextStyle(
            color: AppColors.subtitles,
            fontSize: 20,
          ),
        ),
      );
    } else {
      searchProvider.query = query;
      return FutureBuilder(
          future: _adService.searchAds(searchProvider.organizeData()),
          builder: (BuildContext context, AsyncSnapshot<List<Ad>> snapshot) {
            if (snapshot.hasData) {
              List<Ad> ads = snapshot.data!;
              if (ads.length == 0) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.warning,
                            size: 100,
                            color: AppColors.subtitles,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
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
                      }),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
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
              const SizedBox(
                height: 10,
              ),
              const Text(
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
    final searchProvider = Provider.of<SearchAdsProvider>(context);
    final CategoryProvider _categoryProvider =
        Provider.of<CategoryProvider>(context);

    final Widget dropdownRelevancia = DropdownButtonFormField<String>(
      value: searchProvider.order,
      items: optionsRelevance,
      decoration: decorationDropdownCustom('Seleccione Relevancia'),
      onChanged: (value) {
        searchProvider.order = value!;
      },
    );
    final Widget dropdownFecha = DropdownButtonFormField<String>(
      value: searchProvider.time,
      items: optionsDate,
      decoration: decorationDropdownCustom('Seleccione una fecha'),
      onChanged: (value) {
        searchProvider.time = value!;
      },
    );

    final Widget dropdownCategoria = DropdownButtonFormField<String>(
      value: searchProvider.category == ""
          ? ''
          : _categoryProvider.categories
              .firstWhere((element) => element.id == searchProvider.category)
              .key,
      items: optionsCategory,
      decoration: decorationDropdownCustom('Seleccione una categoria'),
      onChanged: (value) {
        Category categoriaBuscar = _categoryProvider.categories
            .firstWhere((element) => element.key == value);
        searchProvider.category = categoriaBuscar.id;
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
          const SizedBox(
            height: 25,
          ),
          _ButtonFilter(),
          const SizedBox(
            height: 10,
          ),
          _ButtonClean(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  //TODO: Metodos para la asignacion de categoria

}

/// Boton para filtrar los anuncios
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
            //TODO:Aplicar los filtros
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

/// Boton para limpiar los filtros
class _ButtonClean extends StatelessWidget {
  const _ButtonClean({
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
            //Limpiar los filtros
            final SearchAdsProvider _searchProvider =
                Provider.of<SearchAdsProvider>(context, listen: false);
            _searchProvider.category = '';
            _searchProvider.publisher = '';
            _searchProvider.order = '';
            _searchProvider.time = '';
            Navigator.of(context).pop();
          },
          child: const Text('Limpiar',
              style: TextStyle(
                  color: AppColors.third,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto')),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
    );
  }
}
