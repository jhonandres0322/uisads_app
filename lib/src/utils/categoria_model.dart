import 'package:flutter/material.dart';

/// Clase Modelo para realizar el montaje de las categorias de los anuncios
class Categoria {
  final IconData icono;
  final String nombre;
  final Color? color;
  String? id;

  Categoria({
    required this.icono, 
    required this.nombre,
    this.color,
    this.id = '',
  });

  // Setters y Getters
  set setId(String value) => id = value;  
}
// TODO: Agregar la lista de categorias y cambiarlas de archivo

// final List<Categoria> categorias = [
//   Categoria(icono: CustomUisIcons.geometry_icon, nombre: 'Variados'),
//   Categoria(icono: CustomUisIcons.food, nombre: 'Alimentos'),
//   Categoria(icono: CustomUisIcons.key_hand, nombre: 'Alquiler'),
//   Categoria(icono: CustomUisIcons.art, nombre: 'Arte'),
//   Categoria(icono: CustomUisIcons.sports, nombre: 'Deportes'),
//   Categoria(icono: CustomUisIcons.facilitador, nombre: 'Educación'),
//   Categoria(icono: CustomUisIcons.sports, nombre: 'Empleo'),
//   Categoria(icono: CustomUisIcons.work_tool, nombre: 'Servicios'),
//   Categoria(icono: CustomUisIcons.cloathing, nombre: 'Textil'),
//   Categoria(icono: CustomUisIcons.laptop, nombre: 'Tecnología'),
// ];
