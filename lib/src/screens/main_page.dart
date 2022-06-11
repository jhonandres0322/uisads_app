import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // const String userName = 'Hola, Armandosasas';
    // double anchoNombre = userName.length.toDouble();
    // print(anchoNombre);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          // leading:  const CirclePerfilAvatar(width: 91, height: 44,),
          actions: [
            SizedBox(
              width: 20,
            ),
            CirclePerfilAvatar(width: 91, height: 44,),
            // PerfilCirculoUsuario(radio: 22, radioInterno: 2),
            const Spacer(),
            IconButton(
              icon: const Icon(CustomUisIcons.search_right),
              onPressed: () {},
            ),
          ],
          // flexibleSpace: const FlexibleSpaceBar(
          //   title: CirclePerfilAvatar(width: 150, height: 35,),
          //   // centerTitle: true,
          // ),
        ),
        body: const Center(
          child: CirclePerfilAvatar(
            width: 91,
            height: 44,
          ),
        ),
        bottomNavigationBar: const BottomNavigatonBarUisAds(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {},
          child: const Icon(
            CustomUisIcons.megaphone,
            color: AppColors.logoSchoolPrimary,
          ),
        )
    );
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
    return Container(
      height: height,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Stack con el circulo de perfil
          PerfilCirculoUsuario(radio: height / 2, radioInterno: 2),
          // Entre mas abajo del stack mas arriba en pantalla estará
          _BarraPerfilNombre(
            width: width ,
            height: height,
          ),
        ],
      ),
    );
  }
}

///Widget ded barra complemento del perfil
class _BarraPerfilNombre extends StatelessWidget {
  const _BarraPerfilNombre({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    const String userName = 'Hola, Juaasdasdaasdasasdasd';
    double anchoNombre = userName.length.toDouble();
    print(anchoNombre);
    return Container(
      padding: const EdgeInsets.only(right: 5),
      alignment: Alignment.centerRight,
      // width: width*1.35,//(anchoNombre > 10) ? anchoNombre * 9 : anchoNombre * 10,
      height: height / 1.5,
      child: Row(
        children: [
          SizedBox(
            width: height+5,
          ),
          // Texto de nombre del usuario conectado
          const Text(userName,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.titles,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 10
              )
          ),
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
