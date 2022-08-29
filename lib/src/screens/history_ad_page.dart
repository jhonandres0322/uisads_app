import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class HistoryAdPage extends StatelessWidget {
  const HistoryAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: ListView.separated(
              itemBuilder: (context, index) {
                if (index % 4 == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enviar el texto en base a lo que se reciba de la base de datos
                      _HistoryBar(
                        text: 'Hoy',
                      ),
                      _AnuncioCardHistory()
                    ],
                  );
                }
                return _AnuncioCardHistory();
              },
              separatorBuilder: (context, index) => const Divider(
                    color: AppColors.mainThirdContrast,
                    thickness: 1,
                    height: 1,
                  ),
              itemCount: 10)),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {},
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
  const _AnuncioCardHistory({Key? key}) : super(key: key);

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
              image: DecorationImage(
                image: AssetImage('assets/images/anuncio.jpg'),
                fit: BoxFit.cover,
              ),
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
                    children: [Spacer(), _CategoryAdHistory()],
                  ),
                ),
                Text('Titulo del anuncio',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.logoSchoolPrimary)),
                // Icono de favoritos para agregar favorito
                _FavoriteIconButtonSpacer(),
                // Widget para los likes del anuncio
                _LikeDislike(),
                _SeccionVistoContactar(),
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
  const _SeccionVistoContactar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Visto hace 5d',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: AppColors.subtitles)),
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
            child: Row(children: [
              Icon(
                Icons.call,
                color: AppColors.mainThirdContrast,
                size: 12,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Contactar',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 12, color: AppColors.mainThirdContrast),
              ),
            ]),
            onPressed: () {
              log('Contactar Anunciante');
            },
          ),
        ),
      ],
    );
  }
}

/// Widget con la categoria del anuncio del historial
class _CategoryAdHistory extends StatelessWidget {
  const _CategoryAdHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        width: size.width * 0.15,
        height: size.height * 0.03,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.foods,
        ),
        child: Text(
          'Alimentos',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ));
  }
}
