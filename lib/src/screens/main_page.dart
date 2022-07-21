import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/services/ad_service.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';
import 'package:uisads_app/src/widgets/drawer_custom.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // const String userName = 'Hola, Armandosasas';
    // double anchoNombre = userName.length.toDouble();
    // print(anchoNombre);
    final List<Map<String,String>> ads1 = [
      {
        "source" : "assets/quemados/book.jpg",
        "name": "Libro de Calculo"
      },
      {
        "source" : "assets/quemados/pantalla_1.jpeg",
        "name": "Pantalla 21 pulgadas"
      }
    ];

    final List<Map<String,String>> ads2 = [
      {
        "source" : "assets/quemados/computador_1.jpeg",
        "name": "Se vende computador Acer"
      },
      {
        "source" : "assets/quemados/shoes.jpg",
        "name": "Zapatos Dama"
      },
    ];

    final List<Map<String,String>> ads3 = [
      {
        "source" : "assets/quemados/toy.jpg",
        "name": "Juguete Halo"
      },
      {
        "source" : "assets/quemados/book2.jpg",
        "name": "Libro de Algebra"
      },
    ];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          // leading:  const CirclePerfilAvatar(width: 91, height: 44,),
          actions: [
            const SizedBox(
              width: 20,
            ),
            const CirclePerfilAvatar(
              width: 91,
              height: 44,
              userName: 'Usuario',
            ),
            // PerfilCirculoUsuario(radio: 22, radioInterno: 2),
            const Spacer(),
            IconButton(
              icon: const Icon(CustomUisIcons.search_right),
              onPressed: () {
                Navigator.pushNamed( context, 'search');
              },
            ),
          ],
          // flexibleSpace: const FlexibleSpaceBar(
          //   title: CirclePerfilAvatar(width: 150, height: 35,),
          //   // centerTitle: true,
          // ),
        ),
        drawer: const DrawerCustom(),
        body: Column(
          children: [
            // Widget Horizontal con la lista de categorias
            Container(
                width: double.infinity,
                // color: Colors.yellow,
                height: 90,
                child: _ListaCategorias()),
            // CardTable para los anuncios mostrados
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CardTable( images: ads1), 
                    CardTable( images: ads2 ),
                    CardTable( images: ads3 )
                  ],
                ),
              ),
            )
            // Flexible(
            //     // flex: 1,
            //   child: ListView.builder(
            //   itemCount: 4,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: CardTable(),
            //     );
            //   },
            // )),
          ],
        ),
        bottomNavigationBar: const BottomNavigatonBarUisAds(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Navigator.pushNamed(context, 'create-ad');
          },
          child: const Icon(
            CustomUisIcons.megaphone,
            color: AppColors.logoSchoolPrimary,
          ),
        ));
  }
}

/// Widget placeholder para el CardTable
class CardTablePlaceholder extends StatelessWidget {
  const CardTablePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
        ]));
  }
}

/// Widget Horizontal con la lista de categorias
// TODO: Implementar el Widget Horizontal con la lista de categorias y mover de la main page a un archivo separado
class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _adService = AdService();
    return FutureBuilder(
      future: _adService.getCategories(),
      builder: (context, snapshot) {
        if( snapshot.hasData ) {
          final data = snapshot.data as Map<String,dynamic>;
          List categories = data['categories'];
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoriaButton(
                id: categories[index]['_id'],
                icono: getIcon( categories[index]['name'] ),
                nombre: categories[index]['name'],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

/// Widget con el perfil y circulo avatar para el perfil de la pagina
class CirclePerfilAvatar extends StatelessWidget {
  const CirclePerfilAvatar({
    Key? key,
    required this.width,
    required this.height,
    required this.userName,
  }) : super(key: key);

  final double width;
  final double height;
  final String userName;
  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    Preferences _preferences = Preferences();
    // Obtenemos los valores de la pantalla
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Entre mas abajo del stack mas arriba en pantalla estará
            FutureBuilder(
              future: _authService.getProfile( _preferences.profile ),
              builder: ((context, snapshot) {
                if( snapshot.hasData ) {
                  Map<String,dynamic> data =  snapshot.data as Map<String,dynamic>;
                  Profile _profile = Profile.fromJson( data['profile'] as Map<String,dynamic> );
                  return _BarraPerfilNombre(
                    // width: width ,
                    height: height,
                    nombreUser: _profile.name,
                  );
                }
                return const CircularProgressIndicator();

            })),
            // Stack con el circulo de perfil
            PerfilCirculoUsuario(radio: height / 2, radioInterno: 2),
          ],
        ),
      ),
    );
  }
}

///Widget de la barra complemento del perfil
class _BarraPerfilNombre extends StatelessWidget {
  const _BarraPerfilNombre({
    Key? key,
    // required this.width,
    required this.height,
    required this.nombreUser,
  }) : super(key: key);
  // final double width;
  final double height;
  final String nombreUser;

  @override
  Widget build(BuildContext context) {
    double anchoNombre = nombreUser.length.toDouble();
    return Container(
      padding: const EdgeInsets.only(right: 5),
      alignment: Alignment.centerRight,
      // width: width*1.35,//(anchoNombre > 10) ? anchoNombre * 9 : anchoNombre * 10,
      height: height / 1.5,
      child: Row(
        children: [
          SizedBox(
            width: height + 5,
          ),
          // Texto de nombre del usuario conectado
          Text(nombreUser,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: AppColors.titles,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 10)),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(103, 185, 62, 0.2),
      ),
    );
  }
}
