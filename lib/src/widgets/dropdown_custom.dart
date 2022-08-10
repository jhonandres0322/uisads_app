import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';

/// Widget Dropdown Custom para el dropdown de los filtros y pueda ser reutilizado en otros lugares
class DropdownCustom<T> extends StatelessWidget {
  const DropdownCustom({
    Key? key,
    required this.options, 
    this.inputDecoration = const InputDecoration(), 
    required this.onChanged, 
    this.iconData = Icons.keyboard_arrow_down_outlined, 
    this.color = AppColors.subtitles,
  }):super(key: key);

  final List<DropdownMenuItem<T>> options;
  final InputDecoration inputDecoration;
  final ValueChanged<T?> onChanged;
  final IconData iconData;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: options,
      icon: Icon(iconData, color: color),
      decoration: inputDecoration,
      onChanged: onChanged,
    );
  }
}
