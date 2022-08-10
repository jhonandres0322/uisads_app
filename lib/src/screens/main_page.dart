import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/providers/category_provider.dart';
import 'package:uisads_app/src/providers/main_page_provider.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/drawer_custom.dart';
import 'package:uisads_app/src/widgets/list_ad.dart';
import 'package:uisads_app/src/widgets/list_category.dart';
import 'package:uisads_app/src/widgets/profile_avatar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CategoryProvider _categoryProvider = Provider.of<CategoryProvider>(context);
    final mainPageProvider = Provider.of<MainPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.08,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: size.width * 0.05,
          ),
          CirclePerfilAvatar(
            width: size.width * 0.06,
            height: size.height * 0.06,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(CustomUisIcons.search_right),
            onPressed: () {
              Navigator.pushNamed( context, 'search');
            },
          ),
        ],
      ),
      drawer: const DrawerCustom(),
      body: Column(
        children: [
          // Widget Horizontal con la lista de categorias
          SizedBox(
              width: double.infinity,
              // color: Colors.yellow,
              height: size.height * 0.1,
              child: const _ListaCategorias()
          ),
          // CardTable para los anuncios mostrados
          Expanded(
            child: ListAd(
              provider: mainPageProvider,
              ads: mainPageProvider.ads,
              onNextPage: () => mainPageProvider.getAds()
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          _categoryProvider.categorySelect = '';
          Navigator.pushNamed(context, 'create-ad');
        },
        child: const Icon(
          CustomUisIcons.megaphone,
          color: AppColors.logoSchoolPrimary,
        ),
      )
    );
  }
}


/// Widget Horizontal con la lista de categorias
class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListCategory();
  }
}

/// Widget con el perfil y circulo avatar para el perfil de la pagina
class CirclePerfilAvatar extends StatelessWidget {
  const CirclePerfilAvatar({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
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
            _BarraPerfilNombre(
              // width: width ,
              height: height,
              nombreUser: Preferences.name,
            ),
            // Stack con el circulo de perfil
            ProfileAvatar( 
              radius:  0.025,
              image: Preferences.image,
            )
            // PerfilCirculoUsuario(radio: height / 2, radioInterno: 2),
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
