import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        title: const Text(
          'Perfil de Usuario',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
        child: Column(
          children: const [
            _InfoProfile(), 
            _BarTabProfile(), 
            _ListAdsProfile()
          ],
        ),
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
  const _PhotoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const PerfilCirculoUsuario(radio: 50.0),
        FloatingActionButton.small(
          child: const Icon(CustomUisIcons.pencil_square),
          onPressed: () {
            Navigator.pushNamed(context, 'edit-profile');
          },
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
        children: [
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

// ignore: must_be_immutable
class _BartItemProfile extends StatelessWidget {
  Color colorActive = AppColors.logoSchoolPrimary;
  Color colorInactive = AppColors.mainThirdContrast;

  IconData iconData;
  String label;
  int index;
  _BartItemProfile(
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
    return _getListAds(context);
  }

  Widget _getListAds(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.currentPage == 0) {
      return const _MyAdsProfile();
    } else {
      return const _AdsMostValuedProfile();
    }
  }
}

class _MyAdsProfile extends StatelessWidget {
  const _MyAdsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: const [
          CardTable(), 
          CardTable(),
          CardTable(),
          CardTable(),
        ],
      ),
    );
  }
}

class _AdsMostValuedProfile extends StatelessWidget {
  const _AdsMostValuedProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: const [
          CardTable(), 
          CardTable(),
          CardTable(),
          CardTable(),
        ],
      ),
    );
  }
}
