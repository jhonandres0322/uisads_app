import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
class ListCategory extends StatelessWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: _categoryProvider.categories.length,
      itemBuilder: (context, index) {
        return CategoriaButton(
          id: _categoryProvider.categories[index].id,
          icon: getIcon( _categoryProvider.categories[index].name ),
          name: _categoryProvider.categories[index].name,
          enabled: _categoryProvider.categorySelect == _categoryProvider.categories[index].id ? true : false,
        );
      },
    );
  }
}