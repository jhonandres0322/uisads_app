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
              Expanded(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemDrawer(data: items[index]);
                    }),
              ),
              ItemDrawer(data: logoutDrawerInfo),
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
        UtilsNavigator.navigatorProfile(context, Preferences.uid);
        Navigator.pushNamed(context, 'profile', arguments: {'type': 'user'});
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
                    Preferences.name,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainThirdContrast,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    Preferences.email,
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
      onTap: () => getNavigationRoute(context, data['route']),
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

  void getNavigationRoute(BuildContext context, String routeName) {
    if (routeName.isEmpty || routeName == '') {
      showAboutApp(context);
    } else {
      if (routeName == 'login') {
        Preferences.clearInfoLogout();
      }
      Navigator.pushNamedAndRemoveUntil(
          context, routeName, (Route<dynamic> route) => false);
    }
  }

  void showAboutApp(BuildContext context) {
    // Uso del AlertDialog
    var dialog = CustomAlertDialog(
        title: '¿Desea Eliminar este anuncio de su lista de anuncios?',
        icon: CustomUisIcons.bold_problem_alert,
        iconColor: Color(0xffF2C94C),
        onPostivePressed: () {
          Navigator.of(context, rootNavigator: true).pop(true);
        },
        onNegativePressed: () {
          Navigator.of(context, rootNavigator: true).pop(false);
        },
        circularBorderRadius: 10,
        positiveBtnText: 'Eliminar',
        positiveBtnColor: AppColors.reject,
        negativeBtnText: 'Cancelar',
        negativeBtnColor: AppColors.mainThirdContrast,
    );
    showDialog(
        context: context,
        builder: (context) => dialog);
  }
}
