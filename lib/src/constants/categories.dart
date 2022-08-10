import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/constants/style_text.dart';
import 'package:uisads_app/src/utils/categoria_model.dart';
// Lista de categorias 
final List<Categoria> categoriasData = [
      Categoria(icono: CustomUisIcons.geometry_icon, nombre: 'Variados'),
      Categoria(icono: CustomUisIcons.food, nombre: 'Alimentos'),
      Categoria(icono: CustomUisIcons.key_hand, nombre: 'Alquiler'),
      Categoria(icono: CustomUisIcons.art, nombre: 'Arte'),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Deportes'),
      Categoria(icono: CustomUisIcons.facilitador, nombre: 'Educacion'),
      Categoria(icono: CustomUisIcons.briefcase, nombre: 'Empleo'),
      Categoria(icono: CustomUisIcons.work_tool, nombre: 'Servicios'),
      Categoria(icono: CustomUisIcons.cloathing, nombre: 'Textil'),
      Categoria(icono: Icons.laptop, nombre: 'Tecnologia'),
];

IconData getIcon( String name ) {
  int index = categoriasData.indexWhere((element) => element.nombre == name );
  IconData icon = categoriasData[index].icono; 
  return icon;
}

// DropdownItems para filtro de por relevancia
List<DropdownMenuItem<String>> get optionsRelevance {
  List<DropdownMenuItem<String>> lista = [
    DropdownMenuItem(child: Text("Anuncios más votados", style: styleText,), value: "masVotados", enabled: true),
    DropdownMenuItem(child: Text("Anuncios menos votados", style: styleText,), value: "menosVotados"),
  ];
  // Retornamos la lista con los DropdownMenuItem construidos
  return lista;
}
// DropdownItems para fecha de publicacion
List<DropdownMenuItem<String>> get optionsDate{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Última hora", style: styleText,),value: "ultimaHora"),
    DropdownMenuItem(child: Text("Hoy", style: styleText,),value: "hoy"),
    DropdownMenuItem(child: Text("Esta semana", style: styleText,),value: "estaSemana"),
    DropdownMenuItem(child: Text("Este mes", style: styleText,),value: "esteMes"),
    DropdownMenuItem(child: Text("Este año", style: styleText,),value: "esteAño"),
    DropdownMenuItem(child: Text("Más antiguos", style: styleText,),value: "masAntiguos"),
  ];
  return menuItems;
}
// DropdownItems para filtro de categoria
List<DropdownMenuItem<String>> get optionsCategory{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Todos", style: styleText,),value: "variados"),
    DropdownMenuItem(child: Text("Alimentos", style: styleText,),value: "alimentos"),
    DropdownMenuItem(child: Text("Alquiler", style: styleText,),value: "alquiler"),
    DropdownMenuItem(child: Text("Arte", style: styleText,),value: "arte"),
    DropdownMenuItem(child: Text("Deportes", style: styleText,),value: "deportes"),
    DropdownMenuItem(child: Text("Educación", style: styleText,),value: "educación"),
    DropdownMenuItem(child: Text("Empleo", style: styleText,),value: "empleo"),
    DropdownMenuItem(child: Text("Servicios", style: styleText,),value: "servicios"),
    DropdownMenuItem(child: Text("Textil", style: styleText,),value: "textil"),
    DropdownMenuItem(child: Text("Tecnología", style: styleText,),value: "tecnología"),
  ];
  return menuItems;
}

