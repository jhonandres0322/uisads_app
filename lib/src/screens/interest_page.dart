import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cargar del servicio los intereses y usarlos en el provider, limpiar los intereses en caso de tener alguno
    final interestFormProvider = Provider.of<InterestPageProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        centerTitle: true,
        title: const Text(
          'Mis Intereses',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF67B93E),
                Color(0xFF3EB96B),
                Color(0xFFA9B93E)
              ])),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Form(
          key: interestFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widget titulo
              _TitleBar(),
              // Widget descripcion
              _DescriptionBar(),
              // Widget InputCustom
              _InputPalabrasClaves(),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Widget boton
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Spacer(),
                    _ButtonBar(
                      texto: 'Agregar Interes',
                      onPressed: () {
                          _validarInteresAgregado(interestFormProvider, context);
                      },
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              // Widget de intereses
              if (interestFormProvider.interests.isEmpty)
              _InterestWidgetVacio(),
              if (interestFormProvider.interests.isNotEmpty)
              _InterestWidgetFull(),
              if (interestFormProvider.interests.isNotEmpty)
              Row(
                children: [
                  Spacer(),
                  _ButtonGuardar(
                      size: size,
                      onPressed: () {
                        // TODO: Guardar los intereses, limpia el provider y regresa a la pantalla anterior
                        interestFormProvider.cleanInterests();
                        log('Intereses ${interestFormProvider.interests}');
                      },
                      text: 'Guardar'),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      )),
      drawer: const DrawerCustom(),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(
          CustomUisIcons.megaphone,
          color: AppColors.mainThirdContrast,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Metodo para validar un interes agregado
  void _validarInteresAgregado(InterestPageProvider interestFormProvider, BuildContext context) {
    if (interestFormProvider.interests.length < 5) {
      interestFormProvider.formKey.currentState?.save();
      FocusScope.of(context).unfocus();
      log('Agregar Interes ${interestFormProvider.interests}');
    } else {
      log('No se puede agregar mas de 5 intereses');
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        showAlertCustom(
          'No se puede agregar mas de 5 intereses',
          true,
        ),
      );
    }
  }
}

class _ButtonGuardar extends StatelessWidget {
  const _ButtonGuardar({
    Key? key,
    required this.size,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Size size;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      colorBorder: AppColors.primary,
      colorButton: AppColors.primary,
      colorText: Colors.white,
      height: size.height * 0.05,
      width: size.width * 0.25,
      onPressed: onPressed,
      text: text,
      borderRadius: 10.0,
      marginHorizontal: size.width * 0.018,
      marginVertical: size.height * 0.013,
    );
  }
}

// Widget que contiene los elementos agreagados a la lista de intereses
class _InterestWidgetFull extends StatelessWidget {
  const _InterestWidgetFull({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final interestFormProvider = Provider.of<InterestPageProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recuadro de intereses
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(spacing: 5.0, runSpacing: 5.0, children: [
              ...interestFormProvider.interests.map((interest) {
                return _BuildChip(label: interest, color: AppColors.third);
              }).toList(),
            ]),
          ),
          // Mensaje de intereses
          const SizedBox(
            height: 10,
          ),
          Text(
            '* Puedes agregar máx 5 intereses.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.subtitles,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget qeu construye el Chip
class _BuildChip extends StatelessWidget {
  const _BuildChip({
    Key? key,
    required this.label,
    this.color = Colors.blue,
  }) : super(key: key);

  final String label;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
      onDeleted: () {
        final interestFormProvider =
            Provider.of<InterestPageProvider>(context, listen: false);
        interestFormProvider.removeInterest(label);
      },
      deleteIcon: Icon(
        Icons.close,
        color: AppColors.mainThirdContrast,
        size: 15,
      ),
    );
  }
}

/// Widget que contiene el input de palabras claves
class _InputPalabrasClaves extends StatelessWidget {
  const _InputPalabrasClaves({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final interestFormProvider = Provider.of<InterestPageProvider>(context);
    return InputCustom(
      labelText: '',
      onSaved: (value) {
        _validarValorAgregadoInput(value, interestFormProvider, context);
      },
      hintText: 'Ingrese la palabra clave',
      iconData: Icons.abc_outlined,
      keyboardType: TextInputType.emailAddress,
      paddingPorcentage: 0.05,
    );
  }
  // Metodo para validar un valor agregado a la lista de palabras claves en el input
  void _validarValorAgregadoInput(String value, InterestPageProvider interestFormProvider, BuildContext context) {
    if ((value.trim().isNotEmpty && value.trim().length > 2) && !interestFormProvider.interests.contains(value.trim().toLowerCase())) {
        interestFormProvider.addInterest(value.trim().toLowerCase());
        log(value);
    } else {
      ScaffoldMessenger.of(context)
        .showSnackBar(showAlertCustom('Interes Vacio o repetido', true));
    }
  }
}

/// Widget que contendra el elemento de los intereses
class _InterestWidgetVacio extends StatelessWidget {
  const _InterestWidgetVacio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Condicionar este container a la hora de mostrar los intereses guardados
    return Container(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Icon(
              Icons.warning,
              color: AppColors.subtitles,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No se ha añadido ningún interés de búsqueda ',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.subtitles),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ])),
    );
  }
}

/// Widget que contiene el boton de agregar intereses
class _ButtonBar extends StatelessWidget {
  const _ButtonBar({
    Key? key,
    required this.texto,
    required this.onPressed,
  }) : super(key: key);

  final String texto;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: size.height * 0.04,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
            elevation: MaterialStateProperty.all(0),
            textStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 10, color: AppColors.mainThirdContrast))),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: AppColors.mainThirdContrast,
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              texto,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

/// Widget que contiene la descripcion de la pantalla
class _DescriptionBar extends StatelessWidget {
  const _DescriptionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Agrega temas que suelas buscar o palabras clave que podría tener tu anuncio de tu interés:',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: AppColors.subtitles,
        ),
      ),
    );
  }
}

/// Widget que contiene el titulo de la pantalla
class _TitleBar extends StatelessWidget {
  const _TitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        'Intereses de notificación y Búsqueda',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          color: AppColors.logoSchoolPrimary,
        ),
      ),
    );
  }
}
