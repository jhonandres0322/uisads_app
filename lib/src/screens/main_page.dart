import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const CircleAvatar(),
        title: const Text('Main Page'),
        actions: [
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: CirclePerfilAvatar()
      )
    );
  }
}

/// Widget con el perfil y circulo avatar
class CirclePerfilAvatar extends StatelessWidget {

  const CirclePerfilAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: Stack(
        children: const [
          // Entre mas abajo del stack mas arriba en pantalla estará
          _BarraPerfilNombre(),
          _CirculoFondoAvatar(),
          _CirculoFrenteAvatar(),
          
        ],
      ),
    );
  }
}

class _BarraPerfilNombre extends StatelessWidget {
  const _BarraPerfilNombre({
    Key? key,
  }) : super(key: key);

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

class _CirculoFondoAvatar extends StatelessWidget {
  const _CirculoFondoAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 20,
      left: 20,
      child: CircleAvatar(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(50),
            color: AppColors.mainThirdContrast,
            boxShadow: [
              BoxShadow(
                color:Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(-3, 5),
              ),
            ],
          ),
        ),
        radius: 45
      )
    );
  }
}
class _CirculoFrenteAvatar extends StatelessWidget {
  const _CirculoFrenteAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 23,
      left: 23,
      child: CircleAvatar(
        child: Image(
          image: AssetImage('assets/images/avatar.png'), 
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.blue, 
        radius: 42
      )
    );
  }
}


