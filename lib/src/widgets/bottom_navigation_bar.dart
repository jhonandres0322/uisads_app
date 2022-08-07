import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/providers/bottom_navigation_provider.dart';
import 'package:uisads_app/src/providers/category_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
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
    final BottomNavigationBarProvider navegacionProvider = Provider.of<BottomNavigationBarProvider>(context);
    final CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    final ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColors.titles.withOpacity(0.35),
      backgroundColor: AppColors.primary,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
          backgroundColor: AppColors.primary,
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomUisIcons.search_left),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomUisIcons.add_circle),
          label: 'Publicar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: navegacionProvider.currentPage,
      selectedItemColor: AppColors.titles,
      onTap: (int index) {
        navegacionProvider.currentPage = index;
        final String? nameRoute = ModalRoute.of(context)?.settings.name;
        switch (index) {
          case 0:
            if ( nameRoute != 'main' ) {
              Navigator.pushNamed(context, 'main');
            }
            break;
          case 1:
            if ( nameRoute != 'search' ) {
              Navigator.pushNamed(context, 'search');
            }
            break;  
          case 2:
            if ( nameRoute != 'create-ad' ) {
              categoryProvider.categorySelect = '';
              Navigator.pushNamed(context, 'create-ad');
            }
            break;
          case 3:
            if ( nameRoute != 'profile' ) {
              profileProvider.uid = Preferences.uid;
              Navigator.pushNamedAndRemoveUntil(context, 'profile', (route) => false ,arguments: {
                'type': 'user'
              });
            }
          break;  
          default:
        }
      },
    );
  }
}


