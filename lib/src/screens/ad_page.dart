import 'dart:developer';
import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/utils_contact.dart';

class AdPage extends StatelessWidget {
  const AdPage({Key? key}) : super(key: key);
  static String telefonoContacto = '';
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    final AdService _adService = AdService();
    final CategoryProvider _categoryProvider =
        Provider.of<CategoryProvider>(context);
    final AdPageProvider _adPageProvider = Provider.of<AdPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.third),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(CustomUisIcons.search_right, color: AppColors.third),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Ad>(
            future: _adService.getAdById(arguments['id']),
            builder: (context, AsyncSnapshot<Ad> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    _SectionCategoryDate(
                      category: snapshot.data!.category,
                      date: snapshot.data!.createdAt,
                    ),
                    _TitleAdPage(title: snapshot.data!.title),
                    _SectionInfoProfileCity(
                      publisher: snapshot.data!.publisher,
                    ),
                    // Montaje Widget para contacto al usuario
                    Stack(
                      children: [
                        _SectionImages(
                          images: snapshot.data!.images,
                          categoria: snapshot.data!.category,
                        ),
                        Positioned(
                          bottom: 75,
                          right: 10,
                          child: FloatingActionButton(
                            key: const Key('contact'),
                            elevation: 6,
                            backgroundColor: AppColors.primary,
                            onPressed: () async {
                              // print(_adPageProvider.phone);
                              UtilsContact.contactarUsuario(
                                  _adPageProvider.phone,
                                  'Hola, estoy muy interesado en tu anuncio de ${snapshot.data!.title}');
                            },
                            child: const Icon(CustomUisIcons.whatsapp),
                          ),
                        ),
                      ],
                    ),
                    _DescripcionAnuncio(
                      description: snapshot.data!.description,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _ReportSection(
                      idAd: snapshot.data!.id
                    ),
                    Divider(
                      color: AppColors.third,
                    ),
                    _SectionCalification(
                        pointsPositive: snapshot.data!.positvePoints,
                        pointsNegative: snapshot.data!.negativePoints,
                        ad: snapshot.data!.id),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      drawer: const DrawerCustom(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn_navigation',
        elevation: 1,
        foregroundColor: Colors.white,
        key: const Key('navbar'),
        backgroundColor: AppColors.primary,
        onPressed: () {
          _categoryProvider.categorySelect = '';
          Navigator.pushNamed(context, 'create-ad');
        },
        child: const Icon(
          CustomUisIcons.megaphone,
          color: AppColors.mainThirdContrast,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Widget para la sección de reporte de la aplicacion
class _ReportSection extends StatelessWidget {
  const _ReportSection({
    Key? key,
    required String this.idAd
  }) : super(key: key);

  final String idAd;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ReportButton( idAd: idAd ),
        ],
      ),
    );
  }
}

// Widget para el boton de reporte de la aplicacion
class _ReportButton extends StatefulWidget {
  _ReportButton({
    Key? key,
    required String this.idAd
  }) : super(key: key);

  final String idAd;

  @override
  State<_ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<_ReportButton> {
  // Esta propiedad reporte puede ser controlada con un Provider para la realizacion del reporte en el back
  bool _isReported = false;
  @override
  Widget build(BuildContext context) {
    ReportProvider _reportProvider = Provider.of<ReportProvider>(context);
    // Control del reporte
    var dialog = CustomAlertDialog(
      title: _isReported
          ? '¿Desea deshacer el reporte causado al anuncio?'
          : '¿Desea reportar este anuncio como indebido o inapropiado',
      icon: Icons.warning_rounded,
      iconColor: _isReported
          ? const Color(0xffF2C94C)
          : AppColors.reject.withOpacity(0.8),
      onPostivePressed: () {
        Navigator.of(context, rootNavigator: true).pop(true);
      },
      onNegativePressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
      circularBorderRadius: 10,
      positiveBtnText: _reportProvider.isReported ? 'Quitar Reporte' : 'Reportar',
      positiveBtnColor: _reportProvider.isReported ? AppColors.accept : AppColors.reject,
      negativeBtnText: 'Cancelar',
      negativeBtnColor: AppColors.mainThirdContrast,
    );
    return InkWell(
      onTap: () async {
        // Confirmacion de anuncio reportado
        if (_reportProvider.isReported) {
          bool confirmacion = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => dialog);
          if (confirmacion) {
            setState(() {
              _reportProvider.manageReport(widget.idAd);
              log('Confirmado');
            });
          }
        } else {
          bool confirmacion = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => dialog);
          if (confirmacion) {
            setState(() {
              _reportProvider.manageReport(widget.idAd);
              log('Confirmado');
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(CustomUisIcons.block,
                color: _isReported
                    ? AppColors.logoSchoolOpaque
                    : AppColors.reject),
            SizedBox(width: 10),
            Text(
              _isReported ? 'Anuncio Reportado' : 'Reporta este Anuncio',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color:
                    _isReported ? AppColors.logoSchoolOpaque : AppColors.reject,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget que contiene la seccion para la calificacion de un anuncio
class _SectionCalification extends StatelessWidget {
  const _SectionCalification(
      {Key? key,
      required this.pointsPositive,
      required this.pointsNegative,
      required this.ad})
      : super(key: key);

  final int pointsPositive;
  final int pointsNegative;
  final String ad;

  @override
  Widget build(BuildContext context) {
    // Calificacion de anuncio el AdProvider se encarga de la calificacion de un anuncio y se carga directamente del service
    final AdPageProvider _adPageProvider = Provider.of<AdPageProvider>(context);
    String _elementoCalificado = _adPageProvider.choice;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Widget del like
          GestureDetector(
            onTap: () => manageRating(context, Choices.like),
            child: _IconButtonLike(
              icon: CustomUisIcons.bold_like,
              color: _elementoCalificado == Choices.like
                  ? AppColors.accept
                  : AppColors.subtitles.withOpacity(0.5),
              valoracion: pointsPositive,
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          // TODO: Crear un widget que contenga el icono de Favorito y el nombre del favorito
          GestureDetector(
            onTap: () => {
              // Agregacion a favorito
              log('Favorito clicked ${_adPageProvider.favoriteSelection}'),
              _adPageProvider.favoriteSelection == Choices.favorite
                  ? _adPageProvider.favoriteSelection = ''
                  : _adPageProvider.favoriteSelection = Choices.favorite
            },
            child: _IconButtonLike(
              icon: _adPageProvider.favoriteSelection == Choices.favorite ? CustomUisIcons.favorite_bold : CustomUisIcons.favorite_outline,
              color: _adPageProvider.favoriteSelection == Choices.favorite
                  ? AppColors.selectedFavorite
                  : AppColors.subtitles.withOpacity(0.5),
              textIcon: _adPageProvider.favoriteSelection == Choices.favorite ? 'Agregado' :'Agregar Favorito',
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          // Widget del dislike
          GestureDetector(
            onTap: () => manageRating(context, Choices.dislike),
            child: _IconButtonLike(
              icon: CustomUisIcons.bold_dislike,
              color: _elementoCalificado == Choices.dislike
                  ? AppColors.reject
                  : AppColors.subtitles.withOpacity(0.5),
              valoracion: pointsNegative,
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
        ],
      ),
    );
  }

  // Metodo que maneja la calificacion de un anuncio
  void manageRating(BuildContext context, String choice) async {
    final AdService _adService = AdService();
    Response _response =
        await _adService.manageRating({"ad": ad, "choice": choice});

    if (!_response.error) {
      Navigator.pushReplacementNamed(context, 'ad', arguments: {'id': ad});
      final AdPageProvider _adPageProvider =
          Provider.of<AdPageProvider>(context, listen: false);
      _adPageProvider.choice = choice;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(showAlertCustom(_response.message, _response.error));
  }
}

/// Widget que contiene la seccion del boton de like
class _IconButtonLike extends StatelessWidget {
  const _IconButtonLike({
    Key? key,
    required this.icon,
    required this.color,
    this.valoracion, 
    this.textIcon = '',
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final int? valoracion;
  final String? textIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      // height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: AppColors.logoSchoolPrimary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 45,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            valoracion != null ? '($valoracion)' : '$textIcon',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
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
    final CategoryService _categoryService = CategoryService();
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
              color:
                  UtilsOperations.compararCategoryId(categoriasData, category),
            ),
            child: FutureBuilder(
                future: _categoryService.getCategoryId(category),
                builder: (context, AsyncSnapshot<Category> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          const Spacer(),
          Text(
            convertDate(date, context),
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

  String convertDate(String date, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime dateTime = DateTime.parse(date);
    String dayMonth = DateFormat.MMMMd(locale).format(dateTime);
    String year = DateFormat.y(locale).format(dateTime);
    return '$dayMonth, $year';
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
    final AuthService _authService = AuthService();
    final CityService _cityService = CityService();
    final AdPageProvider _adPageProvider = Provider.of<AdPageProvider>(context);
    return FutureBuilder(
        future: _authService.getProfile(publisher),
        builder: (context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
            _adPageProvider.phone = snapshot.data!.cellphone;
            return InkWell(
              onTap: () {
                UtilsNavigator.navigatorProfile(context, publisher);
                String type = '';
                Preferences.uid == publisher ? type = 'user' : type = 'seller';
                Navigator.pushNamed(context, 'profile',
                    arguments: {'type': type});
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: _size.width * 0.05, top: _size.height * 0.02),
                child: Row(
                  children: [
                    ProfileAvatar(
                      radius: 0.025,
                      image: snapshot.data!.image,
                    ),
                    SizedBox(
                      width: _size.width * 0.02,
                    ),
                    // Widget del nombre del vendedor
                    SizedBox(
                      width: _size.width * 0.5,
                      // color: Colors.redAccent ,
                      child: Text(
                        snapshot.data!.name,
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
                          FutureBuilder(
                              future:
                                  _cityService.getCityId(snapshot.data!.city),
                              builder: (context, AsyncSnapshot<City> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.name,
                                    style: const TextStyle(
                                      color: AppColors.mainThirdContrast,
                                      fontSize: 9,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    'Sin Ciudad',
                                    style: TextStyle(
                                      color: AppColors.mainThirdContrast,
                                      fontSize: 9,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              }),
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class _SectionImages extends StatefulWidget {
  const _SectionImages(
      {Key? key, required this.images, required this.categoria})
      : super(key: key);

  final List<Upload> images;
  final String categoria;

  @override
  State<_SectionImages> createState() => _SectionImagesState();
}

class _SectionImagesState extends State<_SectionImages> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AdPageProvider _adPageProvider = Provider.of<AdPageProvider>(context);
    return Column(children: [
      Stack(children: [
        Container(
            // height: 300,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Builder(builder: (context) {
                    return Swiper(
                      controller: _adPageProvider.swiperController,
                      itemCount: widget.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: FutureBuilder(
                              future: HandlerImage.getImageBase64(
                                  widget.images[index]),
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(snapshot.data!),
                                        fit: BoxFit.cover,
                                      ));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: UtilsOperations.compararCategoryId(
                                  categoriasData, widget.categoria),
                              width: 2,
                            ),
                          ),
                        );
                      },
                      pagination: const SwiperPagination(
                        builder: SwiperPagination.dots,
                      ),
                      control: const SwiperControl(
                          color: AppColors.logoSchoolPrimary),
                    );
                  }),
                ),
              ],
            )),
      ]),
      SizedBox(
        height: 20,
      ),
      // Widget para el carrete de fotografias
      Container(
        margin: EdgeInsets.symmetric(horizontal: _size.width * 0.02),
        height: _size.height * 0.08,
        width: double.infinity,
        child: Center(
          child: ListView.builder(
            itemCount: widget.images.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _adPageProvider.swiperController.move(index);
                  });
                },
                child: FutureBuilder(
                    future: HandlerImage.getImageBase64(widget.images[index]),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _size.width * 0.02),
                          child: _CarreteImageElement(
                            image: snapshot.data!,
                            categoria: widget.categoria,
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              );
            },
          ),
        ),
      )
    ]);
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

/// Widget para el elemento cuadrado del carrete de fotografias
class _CarreteImageElement extends StatelessWidget {
  const _CarreteImageElement(
      {Key? key, required this.image, required this.categoria})
      : super(key: key);
  final String image;
  final String categoria;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.2,
      height: _size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: UtilsOperations.compararCategoryId(categoriasData, categoria),
          width: 2,
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Image.file(
            File(image),
            fit: BoxFit.cover,
          )),
    );
  }
}
