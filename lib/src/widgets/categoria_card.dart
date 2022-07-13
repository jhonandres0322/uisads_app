import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class CategoriaCard extends StatelessWidget {
  const CategoriaCard({ 
    Key? key,
    required this.icono, 
    required this.nombre
  }) : super(key: key);

  final IconData icono;
  final String nombre;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        log('Tocaste el boton de la categoria $nombre');
      },
      child: FocusableActionDetector(
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.subtitles,
              width: 1,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          // padding: const  EdgeInsets.symmetric(horizontal: 5),  
          child: Row(
            children: [
              // Widget de categoria
              // Circulo del widget
              Container(
                width: 40,
                // height: size.height * 0.25,
                child: Icon(
                  icono,
                  color: AppColors.subtitles,
                ),
              ),
              SizedBox(
                width: size.height * 0.0025,
              ),
              Text(
                nombre,
                style: const TextStyle(
                  color: AppColors.subtitles,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}