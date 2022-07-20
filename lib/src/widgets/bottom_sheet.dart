import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/dropdown_custom.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';


/// Widget del bottomSheet para las opciones de los filtro
class BottomSheetFilter extends StatelessWidget {

  const BottomSheetFilter({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Creacion de los DropdownCustoms, quedaria pendiente revisar si se optimiza de una mejor forma
    final Widget dropdownRelevancia = DropdownCustom(
      options: optionsRelevance,
      inputDecoration: decorationDropdownCustom('Seleccione Relevancia'),
      onChanged: (value) {
        print(value);
      },
    );
    final Widget dropdownFecha = DropdownCustom(
      options: optionsDate,
      inputDecoration: decorationDropdownCustom('Seleccione una fecha'),
      onChanged: (value) {
        print(value);
      },
    );
    final Widget dropdownCategoria = DropdownCustom(
      options: optionsCategory,
      inputDecoration: decorationDropdownCustom('Seleccione una categoria'),
      onChanged: (value) {
        print(value);
      },
    );
    // Puedo cambiar el SingleChildScrollView por un ListView y eliminar la columna
    return SingleChildScrollView(
      child: Column(
        children: [
          InputCustom(labelText: 'Por Relevancia', input: dropdownRelevancia),
          InputCustom(labelText: 'Por Fecha de Publicacion', input: dropdownFecha),
          InputCustom(labelText: 'Por Categoria', input: dropdownCategoria),
          SizedBox(
            height: 25,
          ),
          ButtonFilter(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class ButtonFilter extends StatelessWidget {
  const ButtonFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.065,
      width: size.width * 0.80,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Buscar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto')),
          style: ElevatedButton.styleFrom(
              primary: AppColors.third,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
    );
  }
}