import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

/// Pantalla que contiene la lista de anuncios favoritos
class FavoritesAdPage extends StatelessWidget {
  const FavoritesAdPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Constantes de la pantalla
    final Size size = MediaQuery.of(context).size;
    final FavoritesService _favoriteService = FavoritesService();
    final favoriteProvider = Provider.of<FavoriteAdsProvider>(context);
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
              ])),
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
                  child: FutureBuilder<ResponseFavoriteAds>(
                      future: _favoriteService
                          .getFavoritesAds(favoriteProvider.currentPage),
                      builder: (context,
                          AsyncSnapshot<ResponseFavoriteAds> snapshot) {
                        return snapshot.hasData
                            ? _ListFavoriteAds(
                              anuncios: snapshot.data!.favorites,
                            )
                            : const Center(child: CircularProgressIndicator());
                      })),
            ],
          ),
        ),
      ),
      drawer: const DrawerCustom(),
      drawerEnableOpenDragGesture: false,
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
          Text('Mis Favoritos',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoSchoolPrimary)),
        ],
      ),
    );
  }
}

/// Widget que contiene la lista de anuncios
class _ListFavoriteAds extends StatelessWidget {
  const _ListFavoriteAds({
    Key? key, 
    required this.anuncios}) : super(key: key);

  final List<Ad> anuncios;
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteAdsProvider>(context);
    print(
        'favoriteProvider.favoriteAds.length: ${favoriteProvider.ads.length}');
    if (anuncios.isEmpty) {
      return const Center(
        child: _InterestWidgetVacio(),
      );
    } else {
      if (favoriteProvider.ads.isEmpty) {
        return const VoidInfoWidget();
      } else {
        return ListAd(
            ads: this.anuncios,
            onNextPage: () => favoriteProvider.getFavoriteAdsNews(),
            provider: favoriteProvider);
      }
    }
  }
}

// Widget Vacio cuando no se han agregado favoritos
class _InterestWidgetVacio extends StatelessWidget {
  const _InterestWidgetVacio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Condicionar este container a la hora de mostrar los intereses guardados
    return Container(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Icon(
              Icons.warning,
              color: AppColors.subtitles,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No se ha añadido anuncios Favoritos ',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.subtitles),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ])),
    );
  }
}
