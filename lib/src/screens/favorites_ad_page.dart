import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';


/// Pantalla que contiene la lista de anuncios favoritos
class FavoritesAdPage extends StatelessWidget {
  const FavoritesAdPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Constantes de la pantalla
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // key: const Key('favorites-ad-page'),  
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
          'Anuncios favoritos',
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
                ]
            )
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // Widget de favoritos
              _FavoriteBar(),
              const SizedBox(
                height: 10,
              ),
              // Widget de anuncios
              Expanded(
                child: CardTable(
                  images: [
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                    {'prueba':'Hola'},
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
    );
  }
}

/// Widget Barra que contiene el titulo de mis anuncios favoritos
class _FavoriteBar extends StatelessWidget {
  const _FavoriteBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      color: AppColors.backgroundBar,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // const Icon(CustomUisIcons.heart, color: AppColors.mainThirdContrast),
          Icon(Icons.favorite, color: AppColors.selectedFavorite),
          SizedBox(width: 10.0),
          Text('Mis Favoritos', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: AppColors.logoSchoolPrimary)),
        ],
      
      ),
    );
  }
}