import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key, required this.images }) : super(key: key);
  final List<Map<String,String>> images;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      // Separacion de la parte superior
      SizedBox(
        height: 5,
      ),
      // Construccion de las tarjetas de la fila
      Row(
        children: [
          AnuncioCard( image: images[0]['source'], name: images[0]['name'] ),
          SizedBox(
            width: 10,
          ),
          AnuncioCard( image: images[1]['source'], name: images[1]['name'])
        ],
      ),
      SizedBox(
        height: 5,
      ),
    ]));
  }
}

/// Tarjeta de anuncio usada para mostrar los anuncios de la aplicacion
class AnuncioCard extends StatelessWidget {
  const AnuncioCard({
    Key? key,
    required this.image,
    required this.name
  }) : super(key: key);
  
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    // Ancho definido En base a la division de la pantalla, anuncios ajustables a esta
    final Size size = MediaQuery.of(context).size;
    double widthCard = (size.width - 30) / 2;
    // TODO: Agregar la imagen de la tarjeta de anuncio cambiar por un FadeInImage
    // TODO: Cambiar color dinamicamente dependiendo de la categoria, el borde

    return Flexible(
      child: Container(
        // color: Colors.red,
        height: widthCard,
        width: widthCard,
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black54,
            width: 2,
          ),
        ),
        child: Column(children: [
          // Imagen del anuncio
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              height: widthCard * 0.8,
              width: widthCard,
              child: Image.asset( image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: widthCard * 0.20,
              width: widthCard,
              child: Row(children: [
                // Titulo del anuncio
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: widthCard * 0.58,
                  child: Text(
                    name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                // Boton de ver mas
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: widthCard * 0.35,
                  height: 18,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                        elevation: MaterialStateProperty.all(0),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 8, color: AppColors.mainThirdContrast))),
                    child: const Text(
                      'Ver más',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'ad');
                    },
                  ),
                ),
              ]
                  // Titulo del anuncio
                  ),
            ),
          )
        ]),
      ),
    );
  }
}
