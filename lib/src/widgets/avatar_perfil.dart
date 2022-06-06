import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';


/// Widget con el circulo del usuario centrado en el stack
/// El size pasado al Perfil circulo usuario permite distribuir el tamaño entre ellos
class PerfilCirculoUsuario extends StatelessWidget {
  const PerfilCirculoUsuario({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    // Width y height del circulo como el tamaño maximo que se puede permitir, en base al size pasado, que sera del mismo tamaño que el stack
    return Container(
      width: size.width * 0.55,
      height: size.width * 0.55,
      decoration: BoxDecoration(
        color: Colors.red,
        // shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // El frente debe tener un size mayor que el fondo
          _CirculoFondoAvatar(size: size,),
          _CirculoFrenteAvatar(size: size,),
        ]
      ),
    );
  }
}



class _CirculoFondoAvatar extends StatelessWidget {
  const _CirculoFondoAvatar({
    Key? key,
    required this.size
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(50),
          color: AppColors.mainThirdContrast,
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color:Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(-3,3),
            ),
          ],
        ),
      ),
      radius: size.width * 0.40,
      // maxRadius: size.width * 0.55,
    );
  }
}

/// Widget frente del usuario Perfil
/// Debe contener un tamaño menor o igual que el de su fondo 
/// para el efecto del shadow y una visualizacion con marco 
class _CirculoFrenteAvatar extends StatelessWidget {
  const _CirculoFrenteAvatar({
    Key? key, 
    required this.size,
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Image(
        image: AssetImage('assets/images/avatar.png'),
        width: double.infinity, 
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.blue, 
      radius: size.width * 0.40,
      // maxRadius: size.width * 0.55,
    );
  }
}


