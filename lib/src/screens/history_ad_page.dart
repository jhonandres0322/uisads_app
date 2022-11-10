import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'dart:io';

class HistoryAdPage extends StatelessWidget {
  const HistoryAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historialAdProvider = Provider.of<HistoryAdsProvider>(context);
    final historialService = HistorialService();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(CustomUisIcons.search_right),
            color: AppColors.mainThirdContrast,
            onPressed: () {},
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
        title: const Text(
          'Historial de Anuncios',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF67B93E),
                Color(0xFF3EB96B),
                Color(0xFFA9B93E)
              ])),
        ),
      ),
      body: SafeArea(
          child: FutureBuilder<ResponseHistorialAds>(
        future:
            historialService.getHistorialAds(historialAdProvider.currentPage),
        builder: (context, AsyncSnapshot<ResponseHistorialAds> snapshot) {
          if (snapshot.hasData) {
            log("Datos de historial");
            log(snapshot.data!.historial.length.toString());
            return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enviar el texto en base a lo que se reciba de la base de datos
                        _HistoryBar(
                          text: 'Vistos Hoy',
                        ),
                        _AnuncioCardHistory(
                          title: snapshot.data!.historial[index].title,
                          mainPage: snapshot.data!.historial[index].mainPage,
                          category: snapshot.data!.historial[index].category,
                          date: snapshot.data!.historial[index].createdAt,
                          idAnuncio: snapshot.data!.historial[index].id,
                        )
                      ],
                    );
                  }
                  return _AnuncioCardHistory(
                    title: snapshot.data!.historial[index].title,
                    mainPage: snapshot.data!.historial[index].mainPage,
                    category: snapshot.data!.historial[index].category,
                    date: snapshot.data!.historial[index].createdAt,
                    idAnuncio: snapshot.data!.historial[index].id,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      color: AppColors.mainThirdContrast,
                      thickness: 1,
                      height: 1,
                    ),
                itemCount: snapshot.data!.historial.length);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
      drawer: const DrawerCustom(),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn_navigation',
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushNamed(context, 'create-ad');
        },
        child: const Icon(
          CustomUisIcons.megaphone,
          color: AppColors.mainThirdContrast,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//Widget que contiene el Texto de la barra del Historial
class _HistoryBar extends StatelessWidget {
  const _HistoryBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: text.length.toDouble() * 12,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      color: AppColors.backgroundBar,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoSchoolPrimary)),
        ],
      ),
    );
  }
}

/// Widget Anuncio Creado para los cards de los anuncios de historial
class _AnuncioCardHistory extends StatelessWidget {
  const _AnuncioCardHistory(
      {Key? key,
      required this.title,
      required this.mainPage,
      this.category = '',
      required this.date, 
      required this.idAnuncio})
      : super(key: key);

  final String title;
  final Upload mainPage;
  final String? category;
  final String date;
  final String idAnuncio;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.logoSchoolSecondary,
      ),
      // height: 100,
      width: double.infinity,
      child: Row(
        children: [
          // Widget de la imagen del anuncio
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: FutureBuilder(
              future: HandlerImage.getImageBase64(mainPage),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.asset(
                    'assets/images/anuncio.jpg',
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // Columna para la descripcion del Anuncio
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Spacer(),
                      _CategoryAdHistory(
                        category: category,
                      )
                    ],
                  ),
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.logoSchoolPrimary)),
                // Icono de favoritos para agregar favorito
                _FavoriteIconButtonSpacer(),
                // Widget para los likes del anuncio
                _LikeDislike(),
                _SeccionVistoContactar(
                  date: date,
                  idAnuncio: idAnuncio,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que contiene el icono de favoritos
class _FavoriteIconButtonSpacer extends StatelessWidget {
  const _FavoriteIconButtonSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Spacer(),
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: AppColors.subtitles,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/// Widget que contiene los iconos con numeros de likes  dislikes del anuncio del historial
class _LikeDislike extends StatelessWidget {
  const _LikeDislike({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.thumb_up),
            color: AppColors.accept,
            onPressed: () {},
          ),
          Text('0',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoSchoolPrimary)),
          IconButton(
            icon: Icon(Icons.thumb_down),
            color: AppColors.reject,
            onPressed: () {},
          ),
          Text('0',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoSchoolPrimary)),
        ],
      ),
    );
  }
}

/// Widgets que contiene el visto y contactar del anuncio
class _SeccionVistoContactar extends StatelessWidget {
  const _SeccionVistoContactar({Key? key, required this.date, required this.idAnuncio})
      : super(key: key);
  final String date;
  final String idAnuncio;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Publicado: ' + convertDate(date, context),
          style: const TextStyle(
            color: AppColors.subtitles,
            fontSize: 10,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          width: 110,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
                elevation: MaterialStateProperty.all(0),
                textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 8, color: AppColors.mainThirdContrast))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Icon(
              //   Icons.call,
              //   color: AppColors.mainThirdContrast,
              //   size: 12,
              // ),
              // SizedBox(
              //   width: 5,
              // ),
              Text(
                'Ver más',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 12, color: AppColors.mainThirdContrast),
              ),
            ]),
            onPressed: () {
              log('Contactar Anunciante');
              Navigator.pushNamed(context, 'ad', arguments: {'id': idAnuncio});
            },
          ),
        ),
      ],
    );
  }

  // Metodo que convierte la fecha a un formato legible
  String convertDate(String date, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime dateTime = DateTime.parse(date);
    String dayMonth = DateFormat.MMMMd(locale).format(dateTime);
    String year = DateFormat.y(locale).format(dateTime);
    return '$dayMonth, $year';
  }
}

/// Widget con la categoria del anuncio del historial
class _CategoryAdHistory extends StatelessWidget {
  const _CategoryAdHistory({
    Key? key,
    this.category = '',
  }) : super(key: key);
  final String? category;
  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService = CategoryService();
    final List<Categoria> categorysInfo = categoriasData;
    final Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        width: size.width * 0.15,
        height: size.height * 0.03,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: UtilsOperations.compararCategoryId(categorysInfo, category!),
        ),
        child: FutureBuilder(
            future: _categoryService.getCategoryId(category!),
            builder: (context, AsyncSnapshot<Category> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
