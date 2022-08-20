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

class AdPage extends StatelessWidget {
  const AdPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final AdService _adService = AdService();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.subtitles),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(CustomUisIcons.search_right, color: AppColors.subtitles),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _adService.getAdById( arguments['id'] ),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if( snapshot.hasData ) {
              return Column(
              children: [
                _SectionCategoryDate(
                  category: snapshot.data!.category,
                  date: snapshot.data!.createdAt,
                ),
                _TitleAdPage( title: snapshot.data!.title),
                _SectionInfoProfileCity(
                  publisher: snapshot.data!.publisher,
                ),
                _SectionImages(
                  images: snapshot.data!.images,
                ),
                _DescripcionAnuncio(
                  description: snapshot.data!.description,
                ),
                _SectionCalification(
                  pointsPositive: snapshot.data!.positvePoints,
                  pointsNegative: snapshot.data!.negativePoints,
                  ad: snapshot.data!.id
                ),
              ],
            );
            } else {
              return  const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
    );
  }
}

class _SectionCalification extends StatelessWidget {
  const _SectionCalification({
    Key? key,
    required this.pointsPositive,
    required this.pointsNegative,
    required this.ad
  }) : super(key: key);

  final int pointsPositive;
  final int pointsNegative;
  final String ad;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Widget del like
          GestureDetector(
            onTap: () => manageRating( context, Choices.like ),
            child: _IconButtonLike(
              icon: CustomUisIcons.like,
              color: AppColors.primary,
              valoracion: pointsPositive,
            ),
          ),
          const SizedBox(
            width: 70,
          ),
          // Widget del dislike
          GestureDetector(
            onTap: () => manageRating( context, Choices.dislike ),
            child: _IconButtonLike(
              icon: CustomUisIcons.dislike,
              color: AppColors.subtitles.withOpacity(0.5),
              valoracion: pointsNegative,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  void manageRating( BuildContext context, String choice ) async {
    final AdService _adService = AdService();
    Response _response = await _adService.manageRating({
      "ad": ad,
      "choice": choice
    });

    if( !_response.error ) {
      Navigator.pushReplacementNamed(
        context, 
        'ad', 
        arguments: {
          'id': ad
        }
      );
    }
    ScaffoldMessenger.of(context).showSnackBar( showAlertCustom( _response.message , _response.error ));
  }

}

class _IconButtonLike extends StatelessWidget {
  const _IconButtonLike({
    Key? key, 
    required this.icon, 
    required this.color,
    required this.valoracion,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final int valoracion;

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
            '($valoracion)',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCategoryDate extends StatelessWidget {
  final String date;
  final String category; 
  
  const _SectionCategoryDate({
    Key? key,
    required this.date,
    required this.category
  }) : super(key: key);

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
              color: AppColors.foods,
            ),
            child: FutureBuilder(
              future: _categoryService.getCategoryId(category),
              builder: (context, AsyncSnapshot<Category> snapshot) {
                if( snapshot.hasData ) {
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
              }
            ),
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

  String convertDate( String date, BuildContext context ) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime dateTime = DateTime.parse(date);
    String dayMonth = DateFormat.MMMMd(locale).format(dateTime);
    String year = DateFormat.y(locale).format(dateTime);
    return '$dayMonth, $year';
  }
}

class _TitleAdPage extends StatelessWidget {
  final String title;
  
  const _TitleAdPage({
    Key? key,
    required this.title
  }) : super(key: key);

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
  const _SectionInfoProfileCity({
    Key? key,
    required this.publisher
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    final CityService _cityService = CityService();
    return FutureBuilder(
      future: _authService.getProfile( publisher ),
      builder: (context, AsyncSnapshot<Profile> snapshot) {
        if( snapshot.hasData ) {
          return InkWell(
            onTap: () {
              UtilsNavigator.navigatorProfile(context, publisher);
              String type = '';
              Preferences.uid == publisher ? type = 'user' : type = 'seller'; 
              Navigator.pushNamed(context, 'profile', arguments: {
                'type': type
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: _size.width * 0.05, 
                top: _size.height * 0.02
              ),
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
                    padding: EdgeInsets.all( _size.height * 0.005 ),
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
                          future: _cityService.getCityId(snapshot.data!.city),
                          builder: (context, AsyncSnapshot<City> snapshot) {
                            if( snapshot.hasData ) {
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

                          }
                        ),
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
        
      }
    );
  }
}


class _SectionImages extends StatefulWidget {
  const _SectionImages({
    Key? key,
    required this.images
  }) : super(key: key);

  final List<Upload> images;

  @override
  State<_SectionImages> createState() => _SectionImagesState();
}

class _SectionImagesState extends State<_SectionImages> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final AdPageProvider _adPageProvider  = Provider.of<AdPageProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(
            height: 300,
            child: Builder(
              builder: (context) {
                return Swiper(
                  controller: _adPageProvider.swiperController,
                  itemCount: widget.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: FutureBuilder(
                        future: HandlerImage.getImageBase64( widget.images[index]),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if ( snapshot.hasData ) {
                            return ClipRRect(
                              child : Image.file(
                                File( snapshot.data! ),
                                fit: BoxFit.cover,
                              )
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.logoSchoolPrimary,
                          width: 2,
                        ),
                      ),
                    );
                  },
                  pagination: const SwiperPagination(
                    builder: SwiperPagination.dots,
                  ),
                  control: const SwiperControl(color: AppColors.logoSchoolPrimary),
                );
              }
            ),
          ),
        ),
        // Widget para el carrete de fotografias
        Container(
          margin: EdgeInsets.symmetric( horizontal: _size.width * 0.02 ),
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
                    future: HandlerImage.getImageBase64( widget.images[index] ),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if( snapshot.hasData ) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: _size.width * 0.02),
                          child: _CarreteImageElement(
                            image: snapshot.data!,
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                );
              },
            ),
          ),
        )
      ]
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

/// Widget para el elemento cuadrado del carrete de fotografias
class _CarreteImageElement extends StatelessWidget {
  const _CarreteImageElement({
    Key? key,
    required this.image
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.2,
      height: _size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.logoSchoolPrimary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Image.file(
          File(image),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}
