import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CategoryProvider _categoryProvider = Provider.of<CategoryProvider>(context);
    final mainPageProvider = Provider.of<MainPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
        ),
        iconTheme: const IconThemeData(color: AppColors.third),
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.08,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: size.width * 0.15,
          ),
          CirclePerfilAvatar(
            width: size.width * 0.06,
            height: size.height * 0.06,
          ),
          Spacer(),
          IconButton(
            icon: Icon(CustomUisIcons.search_right), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: SearchDelegateUis()
              );
            },
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
      ),
      drawer: const DrawerCustom(),
      drawerEnableOpenDragGesture: false,
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              // Widget Horizontal con la lista de categorias
              SizedBox(
                  width: double.infinity,
                  // color: Colors.yellow,
                  height: size.height * 0.10,
                  child: const _ListaCategorias()
              ),
              // CardTable para los anuncios mostrados
              const Expanded( child: _ListAds() )
            ],
          );
        }
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
    );
  }
}


class _ListAds extends StatelessWidget {
  const _ListAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainPageProvider = Provider.of<MainPageProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    String category = categoryProvider.categorySelect;
    return ListAd(
      provider: mainPageProvider,
      ads: mainPageProvider.ads,
      onNextPage: () =>   categoryProvider.categorySelect != '' ? mainPageProvider.getAdsByCategoryNews(category) :  mainPageProvider.getAdsNews()
    );
    // return Container();
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
        // Scaffold.of(context).openDrawer();
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
          Text(
            'Hola,',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: AppColors.titles,
            ),
          ),
          Text(nombreUser,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: AppColors.titles,
                  fontFamily: GoogleFonts.roboto().fontFamily,
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
