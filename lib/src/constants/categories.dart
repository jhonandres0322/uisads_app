import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

// Lista de categorias 
final List<Categoria> categoriasData = [
      Categoria(icono: Icons.apps, nombre: 'Todos'),
      Categoria(icono: CustomUisIcons.geometry_icon, nombre: 'Variados', color: AppColors.primary),
      Categoria(icono: CustomUisIcons.food, nombre: 'Alimentos', color: AppColors.foods),
      Categoria(icono: CustomUisIcons.key_hand, nombre: 'Alquiler', color: AppColors.rental),
      Categoria(icono: CustomUisIcons.art, nombre: 'Arte', color: AppColors.art),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Deportes', color: AppColors.sports),
      Categoria(icono: CustomUisIcons.facilitador, nombre: 'Educacion', color: AppColors.education),
      Categoria(icono: CustomUisIcons.briefcase, nombre: 'Empleo', color: AppColors.job),
      Categoria(icono: CustomUisIcons.work_tool, nombre: 'Servicios', color: AppColors.services),
      Categoria(icono: CustomUisIcons.cloathing, nombre: 'Textil', color: AppColors.textile),
      Categoria(icono: Icons.laptop, nombre: 'Tecnologia', color: AppColors.technology),
];

IconData getIcon( String name ) {
  int index = categoriasData.indexWhere((element) => element.nombre == name );
  IconData icon = categoriasData[index].icono; 
  return icon;
}
// Obtenemos el Id de la categoria y lo asignamos a mis constantes
void getCategoryIdByName( Category category ) {
  int index = categoriasData.indexWhere((element) => element.nombre == category.name );
  categoriasData.elementAt(index).id = category.id;
}
// obtener el nombre de la categoria
String getCategoryNameById( String id ) {
  int index = categoriasData.indexWhere((element) => element.id == id );
  String name = categoriasData.elementAt(index).nombre; 
  return name;
}

// DropdownItems para filtro de por relevancia
List<DropdownMenuItem<String>> get optionsRelevance {
  List<DropdownMenuItem<String>> lista = [
    DropdownMenuItem(child: Text("Seleccione la relevancia", style: styleText,),value: "", enabled: false),
    DropdownMenuItem(child: Text("Anuncios mas votados", style: styleText,), value: "+", enabled: true),
    DropdownMenuItem(child: Text("Anuncios menos votados", style: styleText,), value: "-"),
  ];
  // Retornamos la lista con los DropdownMenuItem construidos
  return lista;
}
// DropdownItems para fecha de publicacion
List<DropdownMenuItem<String>> get optionsDate{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Seleccione la fecha", style: styleText,),value: "", enabled: false),
    DropdownMenuItem(child: Text("Hoy", style: styleText,),value: "24h"),
    DropdownMenuItem(child: Text("Esta semana", style: styleText,),value: "7d"),
    DropdownMenuItem(child: Text("Este mes", style: styleText,),value: "1m"),
  ];
  return menuItems;
}
// DropdownItems para filtro de categoria
List<DropdownMenuItem<String>> get optionsCategory{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Seleccione la categoria", style: styleText,),value: "", enabled: false),
    DropdownMenuItem(child: Text("Variados", style: styleText,),value: "variados"),
    DropdownMenuItem(child: Text("Alimentos", style: styleText,),value: "alimentos"),
    DropdownMenuItem(child: Text("Alquiler", style: styleText,),value: "alquiler"),
    DropdownMenuItem(child: Text("Arte", style: styleText,),value: "arte"),
    DropdownMenuItem(child: Text("Deportes", style: styleText,),value: "deportes"),
    DropdownMenuItem(child: Text("Educacion", style: styleText,),value: "educacion"),
    DropdownMenuItem(child: Text("Empleo", style: styleText,),value: "empleo"),
    DropdownMenuItem(child: Text("Servicios", style: styleText,),value: "servicios"),
    DropdownMenuItem(child: Text("Textil", style: styleText,),value: "textil"),
    DropdownMenuItem(child: Text("Tecnologia", style: styleText,),value: "tecnologia"),
  ];
  return menuItems;
}

