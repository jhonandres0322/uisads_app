import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';


class AdPageGuest extends StatelessWidget {
  const AdPageGuest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.third,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CustomUisIcons.search_right),
            color: AppColors.third,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _SectionCategoryDate(
              category: 'Arte',
              date: '18 de julio de 2022',
            ),
            _TitleAdPage(
              title: 'Titulo del anuncio',
            ),
            _SectionInfoProfileCity(
              publisher: 'Carlos Reyes',
            ),
            // Seccion de Imagenes
            _SectionImages(),
            _CarreteImages(),
            _DescripcionAnuncio(
              description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id ultrices turpis amet. Sem arcu orci, duis morbi velit venenatis a. Tincidunt proin sed viverra dui justo, orci blandit. Molestie nunc sed nisi enim aliquet vel ultrices accumsan. Nisl, sit enim nunc viverra gravida non. Elementum cursus diam curabitur aenean imperdiet augue vitae quis sapien. ',
            ),
            SizedBox(
              height: 20,
            ),
            _ReportSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatonBarUisAds(
        isGuest: true,
      ),
    );
  }
}

// Widget con el carrete de imagenes
class _CarreteImages extends StatelessWidget {
  const _CarreteImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ImageSquare(),
          const SizedBox(
            width: 10,
          ),
          _ImageSquare(),
          const SizedBox(
            width: 10,
          ),
          _ImageSquare(),
          const SizedBox(
            width: 10,
          ),
          _ImageSquare(),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class _ImageSquare extends StatelessWidget {
  const _ImageSquare({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.third,
          width: 2,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/images/cocacola.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//Widget de la seccion de imagenes
class _SectionImages extends StatelessWidget {
  const _SectionImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/cocacola.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Widget que contiene la seccion de fecha del anuncio
class _SectionCategoryDate extends StatelessWidget {
  final String date;
  final String category;

  const _SectionCategoryDate(
      {Key? key, required this.date, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.03,
          ),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.25,
            height: size.height * 0.03,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.textile,
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          Text(
            date,
            style: const TextStyle(
              color: AppColors.subtitles,
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
        ],
      ),
    );
  }
}

/// Widget que contiene la seccion de titulo del anuncio
class _TitleAdPage extends StatelessWidget {
  final String title;

  const _TitleAdPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 10),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.titles,
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SectionInfoProfileCity extends StatelessWidget {
  final String publisher;
  const _SectionInfoProfileCity({Key? key, required this.publisher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // UtilsNavigator.navigatorProfile(context, publisher);
        // String type = '';
        // Preferences.uid == publisher ? type = 'user' : type = 'seller';
        // Navigator.pushNamed(context, 'profile', arguments: {'type': type});
      },
      child: Container(
        margin:
            EdgeInsets.only(left: _size.width * 0.05, top: _size.height * 0.02),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage('assets/images/avatar.png'),
              child: Container(),
            ),
            SizedBox(
              width: _size.width * 0.02,
            ),
            // Widget del nombre del vendedor
            SizedBox(
              width: _size.width * 0.5,
              // color: Colors.redAccent ,
              child: Text(
                publisher,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.subtitles,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            // Widget de la ubicacion del vendedor,
            Container(
              height: _size.height * 0.03,
              // width: 100,
              padding: EdgeInsets.all(_size.height * 0.005),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.logoSchoolPrimary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: _size.width * 0.035,
                  ),
                  SizedBox(
                    width: _size.width * 0.01,
                  ),
                  Text(
                    'Sin Ciudad',
                    style: TextStyle(
                      color: AppColors.mainThirdContrast,
                      fontSize: 9,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: _size.width * 0.03,
            )
          ],
        ),
      ),
    );
  }
}

/// Widget con la descripcion del anuncio
class _DescripcionAnuncio extends StatelessWidget {
  const _DescripcionAnuncio({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: AppColors.logoSchoolPrimary,
          fontSize: 11,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Widget para la sección de reporte de la aplicacion
class _ReportSection extends StatelessWidget {
  const _ReportSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ReportButton(),
        ],
      ),
    );
  }
}

// Widget para el boton de reporte de la aplicacion

class _ReportButton extends StatelessWidget {
  const _ReportButton({
    Key? key,
  }) : super(key: key);
  // Esta propiedad reporte puede ser controlada con un Provider para la realizacion del reporte en el back
  @override
  Widget build(BuildContext context) {
    // Control del reporte
    
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(CustomUisIcons.block,
            color: AppColors.unSelected
          ),
          SizedBox(width: 10),
          Text(
            'Reporta este Anuncio',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: AppColors.unSelected,
            ),
          ),
        ],
      ),
    );
  }
}
