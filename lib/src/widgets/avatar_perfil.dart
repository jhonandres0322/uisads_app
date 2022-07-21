import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

/// Widget con el circulo del usuario centrado en el stack
/// El size pasado al Perfil circulo usuario permite distribuir el tamaño entre ellos
class PerfilCirculoUsuario extends StatelessWidget {
  const PerfilCirculoUsuario({
    Key? key,
    required this.radio, 
    this.radioInterno = 0,
  }) : assert((radioInterno <= radio)),
       super(key: key);
  /// El radio del circulo, el cual es el mismo que el de la imagen de perfil
  /// si no se pasa un valor en [radioInterno] se usa el radio por defecto
  /// y los circulos concentricos tendran el mismo radio, si se pasa un [radioInterno]
  /// el circulo interno tendra un radio menor que el exterior
  final double radio;
  /// El radio minimo del circulo concentrico [radioInterno]
  /// debe ser menor que el radio del circulo principal [radio]
  final double radioInterno;

  @override
  Widget build(BuildContext context) {
    // Width y height del circulo como el tamaño maximo que se puede permitir, en base al size pasado, que sera del mismo tamaño que el stack
    return Container(
      width: radio*2,
      height: radio*2,
      decoration: const BoxDecoration(
        // color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Stack(alignment: Alignment.center, children: [
        // El frente debe tener un size mayor que el fondo
        _CirculoFondoAvatar(
          radius: radio,
        ),
        _CirculoFrenteAvatar(
          radius: radio,
          xradius: radioInterno,
        ),
      ]),
    );
  }
}

class _CirculoFondoAvatar extends StatelessWidget {
  const _CirculoFondoAvatar({
    Key? key,
    required this.radius,
  }) : super(key: key);
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(50),
          color: AppColors.mainThirdContrast,
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(-3, 3),
            ),
          ],
        ),
      ),
      radius: radius,
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
    required this.radius, 
    required this.xradius,
  }) : super(key: key);
  final double radius;
  final double xradius;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: const Image(
          image: AssetImage('assets/images/avatar.png'),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue
        ),
        // maxRadius: size.width * 0.55,
      ),
    );
  }
}
