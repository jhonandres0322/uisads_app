import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';

class CategoriaButton extends StatefulWidget {
  const CategoriaButton(
      {Key? key,
      required this.icon,
      required this.name,
      required this.id,
      required this.enabled})
      : super(key: key);

  final IconData icon;
  final String name;
  final String id;
  final bool enabled;

  @override
  State<CategoriaButton> createState() => _CategoriaButtonState();
}

class _CategoriaButtonState extends State<CategoriaButton> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final _mainPageProvider =
        Provider.of<MainPageProvider>(context, listen: false);
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
                icon: Icon(widget.icon, size: size.height * 0.03),
                color: widget.enabled ? AppColors.mainThirdContrast : AppColors.primaryOpacity,
                onPressed: () {
                  setState(() {
                    _categoryProvider.categorySelect = widget.id;
                    _mainPageProvider.cleanAds();
                    _categoryProvider.categorySelect != '' ? _mainPageProvider.getAdsByCategory(widget.id) : _mainPageProvider.getAds();
                  });
                },
              ),
              decoration: BoxDecoration(
                color: widget.enabled ? AppColors.titles : AppColors.mainThirdContrast,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      widget.enabled ? AppColors.titles : AppColors.primaryOpacity,
                  width: 2,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              widget.name,
              style: TextStyle(
                color: widget.enabled ? AppColors.titles : AppColors.primaryOpacity,
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
