import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget titulo
            _TitleBar(),
            // Widget descripcion
            _DescriptionBar(),
            // Widget InputCustom
            InputCustom(
              labelText: '',
              onSaved: (value) {
                log(value);
              },
              hintText: 'Ingrese la palabra clave',
              iconData: Icons.abc_outlined,
              keyboardType: TextInputType.emailAddress,
              paddingPorcentage: 0.05,
            ),
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
                      log('Agregar Interes');
                    },
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            // Widget de intereses
            _InterestWidget(),
            // _InterestBar(),
          ],
        ),
      )),
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
}

/// Widget que contendra el elemento de los intereses
class _InterestWidget extends StatelessWidget {
  const _InterestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Condicionar este container a la hora de mostrar los intereses guardados
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Icon(Icons.warning, color: AppColors.subtitles, size: 50,),
            const SizedBox(
              height: 10,
            ),
            const Text(
            'No se ha añadido ningún interés de búsqueda ',
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.subtitles),
            textAlign: TextAlign.center,
          ),
          ]
        )
      ),
    );
  }
}
/// Widget que contiene el boton de agregar intereses
class _ButtonBar extends StatelessWidget {
  const _ButtonBar({
    Key? key,
    required  this.texto,
    required this.onPressed,
  }) : super(key: key);

  final String texto;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 18,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.primary),
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
