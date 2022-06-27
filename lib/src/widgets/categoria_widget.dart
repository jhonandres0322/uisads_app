import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class CategoriaButton extends StatelessWidget {
  const CategoriaButton({
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              // Widget de categoria
              // Circulo del widget
              Container(
                width: 50,
                height: size.height * 0.05,
                child: Icon(
                  icono,
                  color: AppColors.subtitles,
                  size: size.height * 0.03,
                ),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.subtitles,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                nombre,
                style: const TextStyle(
                  color: AppColors.subtitles,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}