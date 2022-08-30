import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_screens.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class CreateAdPage extends StatelessWidget {
  const CreateAdPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Widget para el AlertDialog de confirmacion
    var dialog = CustomAlertDialog(
        title: '¿Desea publicar la informacion suministrada al anuncio?',
        icon: Icons.check_circle,
        iconColor: AppColors.accept,
        onPostivePressed: () {
          Navigator.of(context, rootNavigator: true).pop(true);
        },
        onNegativePressed: () {
          Navigator.of(context, rootNavigator: true).pop(false);
        },
        circularBorderRadius: 10,
        positiveBtnText: 'Aceptar',
        positiveBtnColor: AppColors.primary,
        negativeBtnText: 'Cancelar',
        negativeBtnColor: AppColors.mainThirdContrast,
    );

    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        categoryProvider.categorySelect = '';
        return true;
      },
      child: Scaffold(
          appBar: AppBarAd(
            onPressed: () async {
              // Uso del AlertDialog
              bool confirmacion = await showDialog(context: context, barrierDismissible: false, builder: (context) => dialog);
              if (confirmacion) {
                _createAd(context);
              }
            },
            title: 'Crear Anuncio',
            text: 'Publicar',
          ),
          bottomNavigationBar: const BottomNavigatonBarUisAds(),
          body: const SingleChildScrollView(
            child: _FormCreateAd(),
          )),
    );
  }

  // Para crear un anuncio
  void _createAd(BuildContext context) async {
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final CreateAdProvider createAdProvider =
        Provider.of<CreateAdProvider>(context, listen: false);
    final MainPageProvider mainPageProvider =
        Provider.of<MainPageProvider>(context, listen: false);
    if (categoryProvider.categorySelect == '') {
      ScaffoldMessenger.of(context).showSnackBar(showAlertCustom(
          "Por favor seleccione una categoria, si no encuentra la suya seleccione Variados",
          true));
    } else {
      createAdProvider.formKey.currentState?.save();
      createAdProvider.category = categoryProvider.categorySelect;
      Ad adRequest = createAdProvider.handlerData();
      final adService = AdService();
      final response = await adService.createAd(adRequest);
      // Validar el response
      if (response.error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(showAlertCustom(response.message, response.error));
      } else {
        // Limpiar el formulario
        createAdProvider.formKey.currentState?.reset();
        // Actualizar la lista de anuncios
        categoryProvider.categorySelect = '';
        createAdProvider.limpiarObjetos();
        Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
        mainPageProvider.isRefresh = true;
        mainPageProvider.getAdsNews();
        // Mostrar el snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(showAlertCustom(response.message, response.error));
      }
    }
  }
}

class _FormCreateAd extends StatelessWidget {
  const _FormCreateAd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    return Center(
      child: Builder(builder: (context) {
        return Form(
            key: createAdProvider.formKey,
            child: Column(
              children: [
                const _InputTitle(),
                const _InputDescription(),
                SizedBox(
                  height: size.height * 0.02,
                ),
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
            ));
      }),
    );
  }
}

class _InputTitle extends StatelessWidget {
  const _InputTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    return InputCustom(
      labelText: '',
      onSaved: (value) => createAdProvider.title = value ?? '',
      iconData: Icons.abc,
      hintText: 'Pon aqui el titulo',
    );
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    return TextAreaInputCustom(
      hintText: 'Describe tu anuncio',
      labelText: '',
      onSaved: (value) => _createAdProvider.description = value ?? '',
    );
  }
}

class _InputPhotos extends StatelessWidget {
  const _InputPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: _size.height * 0.1,
      width: _size.width * 0.9,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              _CarreteImageElement(index: index),
              SizedBox(
                width: _size.width * 0.01,
              )
            ],
          );
        },
      ),
    );
  }
}

class _CarreteImageElement extends StatefulWidget {
  const _CarreteImageElement({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<_CarreteImageElement> createState() => _CarreteImageElementState();
}

class _CarreteImageElementState extends State<_CarreteImageElement> {
  XFile? _image;
  final _pathImagePlaceholder = 'assets/images/jar-loading.gif';
  final _pathNoImage = 'assets/images/no-image.png';

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _sizeCard = _size.width * 0.17;
    final CreateAdProvider createAdProvider =
        Provider.of<CreateAdProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        if (_image == null) {
          _image = await HandlerImage.openImagePicker(
              context: context,
              index: widget.index,
              images: createAdProvider.images);
          setState(() {});
          return;
        }
        HandlerImage.showImage(
            context: context,
            path: _image!,
            image: Upload(),
            images: createAdProvider.images,
            index: widget.index.toString(),
            onPressedDelete: () {
              final indexList = createAdProvider.images.indexWhere(
                  (element) => element.index == widget.index.toString());
              createAdProvider.images
                  .remove(createAdProvider.images[indexList]);
              _image = null;
              Navigator.pop(context);
              setState(() {});
            },
            onPressedModify: () async {
              _image = await HandlerImage.openImagePicker(
                  context: context,
                  images: createAdProvider.images,
                  index: widget.index);
              Navigator.pop(context);
              setState(() {});
            });
      },
      child: Container(
        width: _sizeCard,
        height: _sizeCard,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: AppColors.logoSchoolPrimary,
            width: 2,
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _image != null
                ? Image.file(File(_image!.path), fit: BoxFit.cover)
                : FadeInImage(
                    placeholder: AssetImage(_pathImagePlaceholder),
                    image: AssetImage(_pathNoImage),
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
          margin: EdgeInsets.only(right: size.width * 0.15),
          child: const Text(
            'Seleccione la categoria que agrupa tu anuncio',
            style: TextStyle(color: AppColors.subtitles),
          ),
        ),
        const SizedBox(
            width: double.infinity,
            // color: Colors.yellow,
            height: 90,
            child: _ListaCategorias()),
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
    return const ListCategory();
  }
}

class _InputVisible extends StatefulWidget {
  const _InputVisible({Key? key}) : super(key: key);

  @override
  State<_InputVisible> createState() => _InputVisibleState();
}

class _InputVisibleState extends State<_InputVisible> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CreateAdProvider createAdProvider =
        Provider.of<CreateAdProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width * 0.5),
          child: const Text(
            'Visibilidad del anuncio',
            style: TextStyle(color: AppColors.subtitles),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          // color: Colors.yellow,
          height: 50,
          child: ToggleSwitch(
            minWidth: size.width * 0.3,
            activeBorders: [Border.all(color: AppColors.primary, width: 1.0)],
            cornerRadius: 20.0,
            activeBgColor: const [AppColors.mainThirdContrast],
            activeFgColor: AppColors.third,
            inactiveBgColor: const Color(0xFFE8E8E8),
            inactiveFgColor: const Color(0xFF8798AD),
            initialLabelIndex: createAdProvider.isVisible ? 1 : 0,
            totalSwitches: 2,
            labels: const ['Desactivado', 'Activado'],
            radiusStyle: true,
            onToggle: (index) {
              createAdProvider.isVisible = !createAdProvider.isVisible;
            },
          ),
        ),
      ],
    );
  }
}
