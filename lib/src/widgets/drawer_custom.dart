import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/items_drawer.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/user.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/logo_app.dart';

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
              CardInfoProfile(),
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
  CardInfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _authService = AuthService();
    final _preferences = Preferences();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'profile', arguments: {
          'type': 'user'
        });
      },
      child: Container(
        child: Row(
          children: [
            SizedBox(width: size.width * 0.05),
            const PerfilCirculoUsuario(radio: 30.0),
            SizedBox(width: size.width * 0.03),
            FutureBuilder(
              future: _authService.getProfile( _preferences.profile ),
              builder: (context, snapshot) {
                if( snapshot.hasData ) {
                  Map<String,dynamic> data =  snapshot.data as Map<String,dynamic>;
                  String email = data['email'];
                  Profile _profile = Profile.fromJson( data['profile'] as Map<String,dynamic> );
                  Widget widget = Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _profile.name,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainThirdContrast,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: AppColors.mainThirdContrast,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                  return widget;
                }
                return const CircularProgressIndicator();
              },
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
      onTap: () => getNavigationRoute(context, data['route'],),
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
              style:
                  TextStyle(
                    color: getColorItem(currentRoute, data['route']),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),
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
    if( routeName.isEmpty ) {
      showAboutApp(context);
    } else {
      if( routeName == 'login' ) {
        Preferences _preferences = Preferences();
        _preferences.token = '';
      }
      Navigator.pushNamedAndRemoveUntil( context, routeName, (Route<dynamic> route) => false);
    }
  }

  void showAboutApp(BuildContext context ) {
    final Size size = MediaQuery.of(context).size;
    showDialog(
      context: context, 
      builder: ( context ) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: size.height * 1
          ),
          content: Column(
            children: [
              Row(
                children: [
                  LogoApp(height: size.height * 0.01)
                ],
              )
            ],
          ), 
        );
      }
    );
  }
}
