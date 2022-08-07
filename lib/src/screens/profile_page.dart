import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/response_score_profile.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
import 'package:uisads_app/src/services/auth_service.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String type = arguments['type'];
    final Size size = MediaQuery.of(context).size;
    final ProfileProvider _profileProvider = Provider.of<ProfileProvider>(context);
    final AuthService _authService = AuthService();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        title: Text(
          arguments['type'] == 'user' ? 'Perfil de Usuario' : 'Perfil del Vendedor',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          const Icon(CustomUisIcons.search_right, color: AppColors.mainThirdContrast),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFF67B93E),
                  Color(0xFF3EB96B),
                  Color(0xFFA9B93E)
                ]
            )
          ),
        ),     
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return FutureBuilder(
              future: _authService.getProfile( _profileProvider.uid ),
              builder: (context,  AsyncSnapshot<Profile> snapshot) {
                if( snapshot.hasData ) {
                  _profileProvider.saveInfoProfile( snapshot.data! );
                  return Column(
                    children: [
                      _InfoProfile( arguments: type, profile: snapshot.data! ), 
                      const _BarTabProfile(), 
                      const _ListAdsProfile()
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
              }
            );
          }
        ),
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
    );
  }
}

class _InfoProfile extends StatelessWidget {
  const _InfoProfile({
    Key? key, 
    required this.arguments,
    required this.profile
  }) : super(key: key);
  
  final String arguments;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.1),
          _PhotoProfile( argument: arguments, image: profile.image ),
          SizedBox(height: size.height * 0.02),
          _NameProfile( name: profile.name ),
          SizedBox(height: size.height * 0.02),
          _DescriptionProfile( description: profile.description ),
          SizedBox(height: size.height * 0.02),
          _CardInfoProfile( idProfile:  profile.uid ),
        ],
      ),
      // child: 
      height: size.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
          Color(0xFF67B93E),
          Color(0xFF3EB96B),
          Color(0xFFA9B93E)
          ]
        )
      ),
    );
  }
}

class _PhotoProfile extends StatelessWidget {
  const _PhotoProfile({
    Key? key, 
    required this.argument, 
    required this.image
  }) : super(key: key);
  
  final String argument;
  final Upload image;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ProfileAvatar( 
          radius: 0.065,
          image: image ,
        ),
        FloatingActionButton.small(
          child: 
            argument == 'user'
            ? const Icon(CustomUisIcons.pencil_square)
            : const Icon(CustomUisIcons.whatsapp),
          onPressed: () {
            if( argument == 'user' ) {
              Navigator.pushNamed(context, 'edit-profile' );
            } else { }
          },
          backgroundColor: AppColors.primary,
        )
      ],
    );
  }
}

class _NameProfile extends StatelessWidget {
  const _NameProfile({Key? key, required this.name }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.mainThirdContrast,
      ),
    );
  }
}

class _DescriptionProfile extends StatelessWidget {
  const _DescriptionProfile({Key? key, required this.description }) : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Text(
        description.isNotEmpty ? description : 'Agregar descripción',
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.mainThirdContrast),
      ),
    );
  }
}

class _CardInfoProfile extends StatelessWidget {
  const _CardInfoProfile({
    Key? key,
    required this.idProfile
  }) : super(key: key);

  final String idProfile;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthService _authService = AuthService();
    return FutureBuilder(
      future: _authService.getScoreProfile(idProfile),
      builder: (context, AsyncSnapshot<ResponseScoreProfile> snapshot) {
        if ( snapshot.hasData ) {
          return Container(
            color: AppColors.mainThirdContrast,
            height: size.height * 0.1,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ItemCardInfoProfile(label: 'Publicaciones', value: snapshot.data!.publications.toString() ),
                _ItemCardInfoProfile(label: 'Puntaje', value: snapshot.data!.score.toString()),  // Like - Dislikes
                _ItemCardInfoProfile(label: 'Valoraciones', value: snapshot.data!.calification.toString() ), // Like + Dislikes
              ],
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


class _ItemCardInfoProfile extends StatelessWidget {
  final String label;
  final String value;
  const _ItemCardInfoProfile({Key? key, 
    required this.label, 
    required this.value
    })
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style:
              const TextStyle(color: AppColors.logoSchoolPrimary, fontSize: 12),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          label,
          style:
              const TextStyle(color: AppColors.logoSchoolPrimary, fontSize: 10),
        )
      ],
    );
  }
}

class _BarTabProfile extends StatelessWidget {
  const _BarTabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.logoSchoolPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _BartItemProfile(
            iconData: CustomUisIcons.advertising,
            label: 'Publicaciones',
            index: 0,
          ),
          _BartItemProfile(
            iconData: CustomUisIcons.library_photo,
            label: 'Mas Valoradas',
            index: 1,
          ),
        ],
      ),
    );
  }
}


class _BartItemProfile extends StatelessWidget {
  final Color colorActive = AppColors.logoSchoolPrimary;
  final Color colorInactive = AppColors.mainThirdContrast;

  final IconData iconData;
  final String label;
  final int index;

  const _BartItemProfile(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          profileProvider.currentPage = index;
        },
        child: Container(
          color: (profileProvider.currentPage == index)
              ? colorActive
              : colorInactive,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: (profileProvider.currentPage == index)
                    ? colorInactive
                    : colorActive,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Text(
                label,
                style: TextStyle(
                    color: (profileProvider.currentPage == index)
                        ? colorInactive
                        : colorActive,
                    fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ListAdsProfile extends StatelessWidget {
  const _ListAdsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Seleccion de la pagina actual
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.currentPage == 0) {
      return const _MyAdsProfile();
    } else {
      return _AdsMostValuedProfile();
    }
  }
}

/// Widget que mostrarla los anuncios del perfil del usuario, implementar como un ListView.builder()
class _MyAdsProfile extends StatelessWidget {
  const _MyAdsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Map<String,String>> books = [
      {
        'name': 'Libro de Calculo',
        'source': 'assets/quemados/book.jpg' ,
      },
      {
        'name': 'Libro de Algebra',
        'source': 'assets/quemados/book2.jpg'
      },
    ];
    final List<Map<String,String>> vars = [
        {
          "name": "Zapatos",
          "source": 'assets/quemados/shoes.jpg'
        },
        {
          "name": "Juguete",
          "source": 'assets/quemados/toy.jpg'
        }
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          CardTable( images: books), 
          CardTable( images: vars ),
        ],
      ),
    );
  }
}
/// Widget que mostrarla los anuncios mas valorados del perfil del usuario, implementar como un ListView.builder()
class _AdsMostValuedProfile extends StatelessWidget {
  const _AdsMostValuedProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // print(size.width * 0.02);
    final List<Map<String,String>> books = [
      {
        'name': 'Libro de Calculo',
        'source': 'assets/quemados/book.jpg' ,
      },
      {
        'name': 'Libro de Algebra',
        'source': 'assets/quemados/book2.jpg'
      },
    ];
    final List<Map<String,String>> vars = [
        {
          "name": "Zapatos Dama",
          "source": 'assets/quemados/shoes.jpg'
        },
        {
          "name": "Juguete Halo",
          "source": 'assets/quemados/toy.jpg'
        }
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          CardTable( images: books), 
          CardTable( images: vars ),
        ],
      ),
    );
  }
}
