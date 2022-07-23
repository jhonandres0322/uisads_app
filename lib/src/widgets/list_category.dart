import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/models/category.dart';
import 'package:uisads_app/src/services/category_service.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoryService = CategoryService();
    return FutureBuilder(
      future: _categoryService.getCategories(),
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
        if( snapshot.hasData ) {
          final List<Category> categories = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoriaButton(
                id: categories[index].id,
                icon: getIcon( categories[index].name ),
                name: categories[index].name,
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}