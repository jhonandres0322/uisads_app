

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_screens.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

// Pagina de inicio para invitados
class MainGuestPage extends StatelessWidget {
  const MainGuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Definimos el dialog para registrarse
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.third),
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
          Spacer(),
          IconButton(
            icon: Icon(CustomUisIcons.search_right),
            onPressed: () async{
               bool confirmacion = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => dialog);

              if (confirmacion) {
                // TODO: Redireccionar a la pagina de registro
                log('Confirmacion');
                Navigator.pushReplacementNamed(context, 'home');
              }
            },
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
      ),
      body: Builder(builder: (context) {
        return Column(
          children: [
            // Widget Horizontal con la lista de categorias
            SizedBox(
                width: double.infinity,
                // color: Colors.yellow,
                height: size.height * 0.10,
                child: const _ListaCategoriasInvitado()),
            // CardTable para los anuncios mostrados
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
        );
      }),
      drawer: const DrawerCustom(),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: const BottomNavigatonBarUisAds(
        isGuest: true,
      ),
    );
  }
}

/// Widget Horizontal con la lista de categorias
class _ListaCategoriasInvitado extends StatelessWidget {
  const _ListaCategoriasInvitado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListCategory(
      isGuest: true,
    );
  }
}