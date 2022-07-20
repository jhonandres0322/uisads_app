import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/screens/main_page.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';

class AdPage extends StatelessWidget {
  const AdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anuncio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.subtitles),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(CustomUisIcons.search_right, color: AppColors.subtitles),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Widget Horizontal con la lista de la categoria y la fecha
            Container(
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.foods,
                    ),
                    child: const Text(
                      'Tecnología',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '16 de Abril de 2022',
                    style: TextStyle(
                      color: AppColors.subtitles,
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            // Widget para el titulo del anuncio
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10),
              alignment: Alignment.topLeft,
              child: const Text(
                'Pantalla 21 pulgadas',
                style: TextStyle(
                  color: AppColors.titles,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Widget para la imagen del vendedor, nombre y ubicacion como elemento fijo
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'profile', arguments: {
                  'type': 'seller'
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    // Widget de la imagen del vendedor
                    // TODO:Reemplazar por mi widget personalizado
                    const PerfilCirculoUsuario(radio: 20, radioInterno: 2),
                    // Container(
                    //   width: 50,
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(50),
                    //     image: DecorationImage(
                    //       image: AssetImage('assets/images/avatar.png'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Widget del nombre del vendedor
                    Container(
                      width: 130,
                      // color: Colors.redAccent ,
                      child: const Text(
                        'Jorge Andres Triana Mojica',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.subtitles,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    // Widget de la ubicacion del vendedor,
                    // TODO: Agregar el icono de ubicacion y Arreglar el texto
                    Container(
                      height: 25,
                      // width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.logoSchoolPrimary,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Bucaramanga',
                            style: TextStyle(
                              color: AppColors.mainThirdContrast,
                              fontSize: 9,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
            ),
            // Widget para el contenido del anuncio carrete principal de fotografias
            // TODO: Controlar el tamaño en base a el tamaño de la pantalla
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                height: 300,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          image: AssetImage('assets/quemados/pantalla_1.jpeg'),
                          placeholder:
                              AssetImage('assets/images/jar-loading.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.logoSchoolPrimary,
                          width: 2,
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                  pagination: const SwiperPagination(
                    builder: SwiperPagination.dots,
                  ),
                  control:
                      const SwiperControl(color: AppColors.logoSchoolPrimary),
                ),
              ),
            ),
            // Widget para el carrete de fotografias
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CarreteImageElement( image: 'assets/quemados/pantalla_1.jpeg',),
                  _CarreteImageElement( image: 'assets/quemados/pantalla_2.jpeg',),
                  _CarreteImageElement( image: 'assets/quemados/pantalla_3.jpeg',),
                  _CarreteImageElement( image: 'assets/quemados/pantalla_4.jpeg',),
                  _CarreteImageElement( image: 'assets/quemados/pantalla_5.jpeg',),
                ],
              ),
            ),
            // Widget para la descripcion del anuncio
            _DescripcionAnuncio(),
            // Widget para el Like y dislike de la pagina
            Container(
              decoration: BoxDecoration(
                // color: Colors.blue[50],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Widget del like
                  GestureDetector(
                    onTap: () {
                      print('like');
                    },
                    child: _IconButtonLike(
                      icon: CustomUisIcons.like,
                      color: AppColors.primary,
                      valoracion: 5,
                    ),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  // Widget del dislike
                  GestureDetector(
                    onTap: () {
                      print('dislike');
                    },
                    child: _IconButtonLike(
                      icon: CustomUisIcons.dislike,
                      color: AppColors.subtitles.withOpacity(0.5),
                      valoracion: 0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatonBarUisAds(),
    );
  }
}

class _IconButtonLike extends StatelessWidget {
  const _IconButtonLike({
    Key? key, 
    required this.icon, 
    required this.color,
    required this.valoracion,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final int valoracion;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 80,
      // height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: AppColors.logoSchoolPrimary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 45,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '($valoracion)',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget con la descripcion del anuncio
class _DescripcionAnuncio extends StatelessWidget {
  const _DescripcionAnuncio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: const Text(
        'Se vendde pantalla de 21 pulgadas LCD, unico dueño, viene con el cable de poder y el conector HDMI para conectar al equipo.',
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: AppColors.logoSchoolPrimary,
          fontSize: 11,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Widget para el elemento cuadrado del carrete de fotografias
class _CarreteImageElement extends StatelessWidget {
  const _CarreteImageElement({
    Key? key,
    required this.image
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.logoSchoolPrimary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: FadeInImage(
          image: AssetImage( image ),
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
