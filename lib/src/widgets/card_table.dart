import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Separacion de la parte superior
          SizedBox(
            height: 10,
          ),
          // Construccion de las tarjetas de la fila
          Row(
            children: [
              AnuncioCard(),
              SizedBox(
                width: 10,
              ),
              AnuncioCard()
            ],
          ),
          
        ]
      )
    );
  }
}

class AnuncioCard extends StatelessWidget {
  const AnuncioCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.red,
        height: 195,
        width: 195,
      ),
    );
  }
}
