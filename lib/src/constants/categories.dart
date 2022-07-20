

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/categoria_model.dart';

final List<Categoria> categoriasData = [
      Categoria(icono: CustomUisIcons.geometry_icon, nombre: 'Variados'),
      Categoria(icono: CustomUisIcons.food, nombre: 'Alimentos'),
      Categoria(icono: CustomUisIcons.key_hand, nombre: 'Alquiler'),
      Categoria(icono: CustomUisIcons.art, nombre: 'Arte'),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Deportes'),
      Categoria(icono: CustomUisIcons.facilitador, nombre: 'Educación'),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Empleo'),
      Categoria(icono: CustomUisIcons.work_tool, nombre: 'Servicios'),
      Categoria(icono: CustomUisIcons.cloathing, nombre: 'Textil'),
      Categoria(icono: Icons.laptop, nombre: 'Tecnología'),
];

IconData getIcon( String name ) {
  int index = categoriasData.indexWhere((element) => element.nombre == name );
  IconData icon = categoriasData[index].icono; 
  return icon;
}