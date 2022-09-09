import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/widgets/custom_alert_dialog.dart';

/// Widget bottomNavigation Bar para el control de las rutas de navegacion y ejecucion del drawer
/// El drawer se muestra en el lado izquierdo de la pantalla
/// El control de las rutas de navegacion se realiza en el main.dart
/// El control de la ejecucion del drawer se realiza en el main.dart
/// Este Widget no es reusable debido al provider, se recomienda desconectarlo si se quiere trabajar
class BottomNavigatonBarUisAds extends StatelessWidget {
  const BottomNavigatonBarUisAds({Key? key, this.isGuest = false}) : super(key: key);

  final bool? isGuest;

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
      onTap: (int index) async{
        navegacionProvider.currentPage = index;
        final String? nameRoute = ModalRoute.of(context)?.settings.name;
        if (isGuest!) {
          var dialog = CustomAlertDialog(
            title: 'Posee permisos Limitados como Invitado ¿Desea Registrarse o Iniciar sesión?',
            icon: Icons.info,
            iconColor: const Color(0xff2F80ED),
            onPostivePressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            onNegativePressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            circularBorderRadius: 10,
            positiveBtnText: 'Aceptar',
            positiveBtnColor:  AppColors.accept ,
            negativeBtnText: 'Cancelar',
            negativeBtnColor: AppColors.mainThirdContrast,
          );
          switch (index) {
            default:
              bool confirmacion = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => dialog);

              if (confirmacion) {
                log('Confirmacion');
                Navigator.pushReplacementNamed(context, 'home');
              }
          }
        } else {
          categoryProvider.categorySelect = '';
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
        }
        
      },
    );
  }
}
