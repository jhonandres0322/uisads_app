import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0),
        child: AppBar(
          backgroundColor: Colors.white,
          // leading:  CirclePerfilAvatar(size: size,),
          title: const Text('Main Page', style: TextStyle(color: Colors.black),),
          actions: [
            // const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: PerfilCirculoUsuario(radio: 100, radioInterno: 3, ),
      )
    );
  }
}

/// Widget con el perfil y circulo avatar para el perfil de la pagina
class CirclePerfilAvatar extends StatelessWidget {

  const CirclePerfilAvatar({
    Key? key, 
    required this.size
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    print('Size: ${size.width} y ${size.height}');
    // Obtenemos los valores de la pantalla
    return Container(
      // color: Colors.redAccent,
      width: size.width * 0.55,
      height: size.width * 0.3,
      child: Stack(
        children: [
          // Entre mas abajo del stack mas arriba en pantalla estará
          _BarraPerfilNombre(size: size,),
          // Stack con el circulo de perfil
          // PerfilCirculoUsuario(size: size)
          
        ],
      ),
    );
  }
}
///Widget ded barra complemento del perfil
class _BarraPerfilNombre extends StatelessWidget {
  const _BarraPerfilNombre({
    Key? key,
    required this.size
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 38,
      left: 40,
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        width: 170,
        height: 57.83,
        child: const Text(
          'Hola, Julio', 
          textAlign: TextAlign.end, 
          style: TextStyle(
            color: AppColors.titles, 
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 13
          )
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(103, 185, 62, 0.2),
        ),
      ),
    );
  }
}