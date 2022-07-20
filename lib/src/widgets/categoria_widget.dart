import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';

class CategoriaButton extends StatefulWidget {
  CategoriaButton({
     Key? key, 
     required this.icono, 
     required this.nombre,
     required this.id
  }) : super(key: key);

  final IconData icono;
  final String nombre;
  final String id;

  @override
  State<CategoriaButton> createState() => _CategoriaButtonState();
}

class _CategoriaButtonState extends State<CategoriaButton> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FocusableActionDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            // Widget de categoria
            // Circulo del widget
            Container(
              width: 50,
              height: size.height * 0.05,
              child: IconButton(
                icon: Icon( widget.icono, size: size.height * 0.03),
                color: enabled ? AppColors.titles : AppColors.subtitles,
                onPressed: () {
                  setState(() {
                    log('Tocaste el boton de la categoria ${widget.id}');
                    if( enabled ) {
                      enabled = false;
                    } else {
                      enabled = true;
                    }
                  });
                },
              ),
              decoration: BoxDecoration(
                // color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: enabled ? AppColors.titles : AppColors.subtitles,
                  width: 2,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              widget.nombre,
              style: TextStyle(
                color:  enabled ? AppColors.titles : AppColors.subtitles,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}