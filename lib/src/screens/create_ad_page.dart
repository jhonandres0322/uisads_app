import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uisads_app/src/constants/categories.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/providers/create_ad_provider.dart';
import 'package:uisads_app/src/services/ad_service.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';

class CreateAdPage extends StatelessWidget {
  const CreateAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainThirdContrast,
        elevation: 10.0,
        title:  const Text(
          'Crear Anuncio',
          style: TextStyle(
            color: AppColors.subtitles
          ),
      ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric( vertical: 10, horizontal: 10 ),
            child: ElevatedButton(
              child: const Text('Publicar'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                onPrimary: AppColors.mainThirdContrast,
                primary: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular( 20.0 )
                ),
              ),
            ),
          )
        ]
      ),
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      body: const SingleChildScrollView(
        child: FormCreateAd(),
      )
    );
  }
}


class FormCreateAd extends StatelessWidget {
  const FormCreateAd({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final formKey = _createAdProvider.formKey;
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const _InputTitle(),
              const _InputDescription(),
              const _InputPhotos(),
              SizedBox(
                height: size.height * 0.02,
              ),
              const _InputCategories(),
              SizedBox(
                height: size.height * 0.02,
              ),
              const _InputVisible()
            ],
          )
        ),
      ),
    );
  }
}

class _InputTitle extends StatelessWidget {
  const _InputTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final Widget inputTitle =  TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      onSaved: (value) => _createAdProvider.title = value ?? '',
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: '    Pon aqui tu anuncio',
        hintStyle: const TextStyle(
          fontSize: 13.0, 
          color: AppColors.subtitles,
        ),
        prefixIconColor: AppColors.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.primary, width: 1.5
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
          color: AppColors.primary, width: 1.5)
        )
      )
    );
    return InputCustom(labelText: '', input: inputTitle);
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final Widget inputDescription =  TextFormField(
      autofocus: false,
      obscureText: false,
      textAlign: TextAlign.center,
  
      keyboardType: TextInputType.text,
      onSaved: (value) => _createAdProvider.description = value ?? '',
      maxLines: 6,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: '                                                                                                  Describe tu anuncio',
        hintStyle: const TextStyle(
          fontSize: 13.0, 
          color: AppColors.subtitles,
        ),
        prefixIconColor: AppColors.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.primary, width: 1.5
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
          color: AppColors.primary, width: 1.5)
        )
      )
    );
    return InputCustom(labelText: 'Descripción', input: inputDescription);
  }
}

class _InputPhotos extends StatelessWidget {
  const _InputPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _CarreteImageElement( image: 'assets/images/no-image.png'),
          _CarreteImageElement( image: 'assets/images/no-image.png'),
          _CarreteImageElement( image: 'assets/images/no-image.png'),
          _CarreteImageElement( image: 'assets/images/no-image.png'),
          _CarreteImageElement( image: 'assets/images/no-image.png'),
        ],
      ),
    );
  }
}

class _CarreteImageElement extends StatelessWidget {
  const _CarreteImageElement({
    Key? key,
    required this.image
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.logoSchoolPrimary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: FadeInImage(
          image: AssetImage( image ),
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _InputCategories extends StatelessWidget {
  const _InputCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only( right:  size.width * 0.15),
          child: const Text(
            'Seleccione la categoria que agrupa tu anuncio',
            style: TextStyle(
              color: AppColors.subtitles
            ),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          // color: Colors.yellow,
          height: 90,
          child: _ListaCategorias()
        ),
      ],
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _adService = AdService();
    return FutureBuilder(
      future: _adService.getCategories(),
      builder: (context, snapshot) {
        if( snapshot.hasData ) {
          final data = snapshot.data as Map<String,dynamic>;
          List categories = data['categories'];
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoriaButton(
                id: categories[index]['_id'],
                icono: getIcon( categories[index]['name'] ),
                nombre: categories[index]['name'],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _InputVisible extends StatelessWidget {
  const _InputVisible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only( right:  size.width * 0.5),
          child: const Text(
            'Visibilidad del anuncio',
            style: TextStyle(
              color: AppColors.subtitles
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          // color: Colors.yellow,
          height: 50,
          child: ToggleSwitch(
            minWidth: size.height * 0.15,
            activeBorders: [
              Border.all(
                color: AppColors.primary,
                width: 1.0
              )
            ],
            cornerRadius: 20.0,
            activeBgColor: const [AppColors.mainThirdContrast],
            activeFgColor: AppColors.third,
            inactiveBgColor: const Color(0xFFE8E8E8),
            inactiveFgColor: const Color(0xFF8798AD),
            initialLabelIndex: 1,
            totalSwitches: 2,
            labels: const ['Desactivado', 'Activado'],
            radiusStyle: true,
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
        ),
      ],
    );
  }
}