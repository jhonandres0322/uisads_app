import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
            title: const Text(
              'Perfil de Usuario',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              const Icon(Icons.search, color: AppColors.mainThirdContrast),
              SizedBox(
                width: size.width * 0.03,
              )
            ]),
        body: Column(
          children: const [
            _InfoProfile(), 
            _BarTabProfile(),
          ],
        ),
        bottomNavigationBar: const BottomNavigatonBarUisAds(),
    );
  }
}

class _InfoProfile extends StatelessWidget {
  const _InfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.1),
          const _PhotoProfile(),
          SizedBox(height: size.height * 0.02),
          const _NameProfile(),
          SizedBox(height: size.height * 0.02),
          const _DescriptionProfile(),
          SizedBox(height: size.height * 0.02),
          const _CardInfoProfile(),
        ],
      ),
      height: size.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF67B93E),
        Color(0xFF3EB96B),
        Color(0xFFA9B93E)
      ])),
    );
  }
}

class _PhotoProfile extends StatelessWidget {
  const _PhotoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const PerfilCirculoUsuario(radio: 50.0),
        FloatingActionButton.small(
          child: const Icon(CustomUisIcons.pencil_square),
          onPressed: () {},
          backgroundColor: AppColors.primary,
        )
      ],
    );
  }
}

class _NameProfile extends StatelessWidget {
  const _NameProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Jorge Gonzalez',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.mainThirdContrast,
      ),
    );
  }
}

class _DescriptionProfile extends StatelessWidget {
  const _DescriptionProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: const Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tellus dictum mi maecenas leo mauris mattis donec.',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.mainThirdContrast),
      ),
    );
  }
}

class _CardInfoProfile extends StatelessWidget {
  const _CardInfoProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.mainThirdContrast,
      height: size.height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ItemCardInfoProfile(label: 'Publicaciones', value: '102'),
          _ItemCardInfoProfile(label: 'Likes', value: '120'),
          _ItemCardInfoProfile(label: 'Valoraciones', value: '46'),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _ItemCardInfoProfile extends StatelessWidget {
  String label;
  String value;
  _ItemCardInfoProfile({Key? key, required this.label, required this.value})
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
        children: [
          _BartItemProfile(
              backgroundColor: AppColors.logoSchoolPrimary,
              iconData: CustomUisIcons.advertising,
              label: 'Publicaciones',
              iconColor: AppColors.mainThirdContrast,
              ),
          _BartItemProfile(
              backgroundColor: AppColors.mainThirdContrast,
              iconData: CustomUisIcons.library_photo,
              label: 'Mas Valoradas',
              iconColor: AppColors.logoSchoolPrimary,
              ),
        ],
      ),
    );
  }
}

class _BartItemProfile extends StatelessWidget {
  Color backgroundColor;
  Color iconColor;
  IconData iconData;
  String label;
  _BartItemProfile(
      {Key? key,
      required this.backgroundColor,
      required this.iconData,
      required this.label,
      required this.iconColor,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        color: backgroundColor,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              label,
              style: TextStyle(color: iconColor, fontSize: 10.0),
            )
          ],
        ),
      ),
    );
  }
}
