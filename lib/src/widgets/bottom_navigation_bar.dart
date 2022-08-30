import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

/// Widget bottomNavigation Bar para el control de las rutas de navegacion y ejecucion del drawer
/// El drawer se muestra en el lado izquierdo de la pantalla
/// El control de las rutas de navegacion se realiza en el main.dart
/// El control de la ejecucion del drawer se realiza en el main.dart
/// Este Widget no es reusable debido al provider, se recomienda desconectarlo si se quiere trabajar
class BottomNavigatonBarUisAds extends StatelessWidget {
  const BottomNavigatonBarUisAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Llamado al provider
    final BottomNavigationBarProvider navegacionProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColors.mainThirdContrast.withOpacity(0.65),
      backgroundColor: AppColors.primary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: AppColors.mainThirdContrast,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
          backgroundColor: AppColors.primary,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CustomUisIcons.search_left,
          ),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favoritos',
        ),
      ],
      currentIndex: navegacionProvider.currentPage,
      onTap: (int index) {
        navegacionProvider.currentPage = index;
        final String? nameRoute = ModalRoute.of(context)?.settings.name;
        categoryProvider.categorySelect = '';
        //TODO: Descomentar para usarlo en la navegacion actual de la aplicacion
        switch (index) {
          case 0:
            if ( nameRoute != 'main' ) {
              Navigator.pushNamed(context, 'main');
            }
            break;
          case 1:
            if ( nameRoute != 'search' ) {
              showSearch(
                context: context,
                delegate: SearchDelegateUis()
              );
            }
            break;
          case 2:
            if ( nameRoute != 'profile' ) {
              Scaffold.of(context).openDrawer();
              // UtilsNavigator.navigatorProfile(context, Preferences.uid );
              // Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false ,arguments: {
              //   'type': 'user'
              // });
            }
            break;
          case 3:
            if ( nameRoute != 'favorites-ad' ) {
              Navigator.pushNamed(context, 'favorites-ad');
            }
          break;
          default:
        }
      },
    );
    // return BottomAppBar(
    //   //bottom navigation bar on scaffold
    //   color: AppColors.primary,
    //   shape: CircularNotchedRectangle(), //shape of notch
    //   notchMargin: 5, //notche margin between floating button and bottom appbar
    //   child: Row(
    //     //children inside bottom appbar
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       IconButton(
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.white,
    //         ),
    //         tooltip: 'Inicio',
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           CustomUisIcons.search_left,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           Icons.person,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           Icons.favorite_border,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
