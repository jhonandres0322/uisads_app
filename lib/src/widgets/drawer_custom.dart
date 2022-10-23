import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final items = listDrawer;
    final Size size = MediaQuery.of(context).size;
    return Drawer(
        elevation: 1.0,
        child: SafeArea(
          child: Column(
            children: [
              const CardInfoProfile(),
              SizedBox(height: size.height * 0.05),
              if (Preferences.name != '')
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ItemDrawer(data: items[index]);
                      }),
                ),
              if (Preferences.name == '')
                Expanded(
                  child: ListView.builder(
                      itemCount: listDrawerNoLogin.length,
                      itemBuilder: (context, index) {
                        return ItemDrawer(data: listDrawerNoLogin[index]);
                      }),
                ),
              if (Preferences.name != '')
                ItemDrawer(data: logoutDrawerInfo),
              if (Preferences.name == '')
                ItemDrawer(data: logoutDrawerOutNoLogin),
              SizedBox(
                height: size.height * 0.05,
              )
            ],
          ),
        ));
  }
}

class CardInfoProfile extends StatelessWidget {
  const CardInfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (Preferences.token != '') {
          UtilsNavigator.navigatorProfile(context, Preferences.uid);
          Navigator.pushNamed(context, 'profile', arguments: {'type': 'user'});
        }
      },
      child: Container(
        child: Row(
          children: [
            SizedBox(width: size.width * 0.05),
            ProfileAvatar(
              radius: 0.03,
              image: Preferences.image,
            ),
            SizedBox(width: size.width * 0.03),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Preferences.name == '' ? 'Invitado' : Preferences.name,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainThirdContrast,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    Preferences.email == '' ? 'invitado@invitado.com ' : Preferences.email,
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: AppColors.mainThirdContrast,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
        height: size.height * 0.18,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF67B93E),
          Color(0xFF3EB96B),
          Color(0xFFA9B93E)
        ])),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final Map<String, dynamic> data;
  const ItemDrawer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // return Text('${data['label']}');
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return InkWell(
      onTap: () => getNavigationRoute(context, data['route'], currentRoute),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.015),
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: getColorContainer(currentRoute, data['route'])),
              bottom: BorderSide(
                  color: getColorContainer(currentRoute, data['route'])),
            ),
            color: getColorContainer(currentRoute, data['route'])
                .withOpacity(0.2)),
        child: Row(
          children: [
            Icon(data['icon'],
                size: size.height * 0.03,
                color: getColorItem(currentRoute, data['route'])),
            SizedBox(width: size.width * 0.04),
            Text(
              data['label'],
              style: TextStyle(
                  color: getColorItem(currentRoute, data['route']),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Color getColorContainer(final currentRoute, String route) =>
      currentRoute == route ? AppColors.primary : AppColors.mainThirdContrast;

  Color getColorItem(final currentRoute, String route) =>
      currentRoute == route ? AppColors.primary : AppColors.logoSchoolPrimary;

  void getNavigationRoute(BuildContext context, String routeName, String? rutaActual) {
    if (routeName.isEmpty || routeName == '') {
      showAboutApp(context);
    } else {
      if (routeName == 'home') {
        Preferences.clearInfoLogout();
      }
      if(routeName != rutaActual){
        Navigator.pushNamedAndRemoveUntil(
          context, routeName, (Route<dynamic> route) => false);
      }
    }
  }
  // AlertDialog para el Acerca de la App
  void showAboutApp(BuildContext context) {
    // Uso del AlertDialog
    var dialog = AlertDialog(
      alignment: Alignment.center ,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            CustomUisIcons.uis_ads_icon,
            color: AppColors.primary,
            size: 30,
          ),
          SizedBox(width: 10),
          Image.asset(
            'assets/images/logo_school.png',
            height: 30,
          ),
          SizedBox(width: 10),
          Image.asset(
            'assets/images/logo_uis.png',
            height: 30,
          )
        ],
      ),
      content: Text('UISADS', textAlign: TextAlign.center,),
      contentTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      actions: <Widget>[
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Aplicativo móvil desarrollado en busca de dar una solución a la comunidad universitaria en su necesidad de poseer una plataforma de intercambio de artículos y servicios que sea fácil y cómoda de usar', 
            textAlign: TextAlign.justify, 
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.titles,
            )
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Desarrollada por Jorge Andrés Triana Mojica y Jhon Andrés Parra Rodriguez y Elkin Fernández como proyecto de grado para optar por el titulo de Ingenieria de Sistemas.', 
            textAlign: TextAlign.justify, 
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.titles,
            )
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            'Powered by PFT Technologies', 
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.subtitles,
            )
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            child: Text('Cerrar'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.primary),
            ),  
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) => dialog);
  }
}
