import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class EditAdPage extends StatelessWidget {
  const EditAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget para el AlertDialog de confirmacion
    var dialog = CustomAlertDialog(
      title: '¿Desea guardar los cambios realizados al anuncio?',
      icon: CustomUisIcons.info_bold,
      iconColor: const Color(0xff2F80ED),
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

    return Scaffold(
      appBar: AppBarAd(
        onPressed: () async {
          bool confirmacion = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => dialog);
          if (confirmacion) {
            _editAd(context);
          }
        },
        title: 'Editar Anuncio',
        text: 'Editar',
      ),
      body: const SingleChildScrollView(child: _FormEditAd()),
    );
  }

  _editAd(BuildContext context) async {
    final adService = AdService();
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final adPageProvider = Provider.of<AdPageProvider>(context, listen: false);
    final editAdProvider = Provider.of<EditAdProvider>(context, listen: false);
    editAdProvider.formKey.currentState?.save();
    editAdProvider.category = categoryProvider.categorySelect;
    editAdProvider.images = adPageProvider.ad.images;
    final Response resp = await adService.editAd(
        adPageProvider.ad.id, editAdProvider.handlerData());
    ScaffoldMessenger.of(context)
        .showSnackBar(showAlertCustom(resp.message, resp.error));
    if (!resp.error) {
      editAdProvider.limpiarObjetos();
      Navigator.pop(context);
    }
  }
}

class _FormEditAd extends StatelessWidget {
  const _FormEditAd({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final adPageProvider = Provider.of<AdPageProvider>(context);
    final adEdited = adPageProvider.ad;
    final size = MediaQuery.of(context).size;
    final editAdProvider = Provider.of<EditAdProvider>(context);
    return Form(
        key: editAdProvider.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.04),
            _InputTitle(title: adEdited.title),
            _InputDescription(description: adEdited.description),
            SizedBox(height: size.height * 0.02),
            _InputPhotos(images: adEdited.images),
            SizedBox(height: size.height * 0.02),
            const _InputCategories(),
            SizedBox(height: size.height * 0.03),
            _InputVisible(visible: adEdited.visible)
          ],
        ));
  }
}

class _InputTitle extends StatelessWidget {
  const _InputTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final editAdProvider = Provider.of<EditAdProvider>(context);
    return InputCustom(
      labelText: 'Titulo del Anuncio',
      onSaved: (value) => editAdProvider.title = value ?? '',
      iconData: Icons.abc,
      hintText: 'Ingrese su nombre',
      initialValue: title,
    );
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key, required this.description})
      : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    final editAdProvider = Provider.of<EditAdProvider>(context);
    return TextAreaInputCustom(
      hintText: 'Describe tu anuncio',
      labelText: 'Descripción del anuncio',
      initialValue: description,
      onSaved: (value) => editAdProvider.description = value ?? '',
    );
  }
}

class _InputPhotos extends StatelessWidget {
  const _InputPhotos({Key? key, required this.images}) : super(key: key);

  final List<Upload> images;
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
          Upload image = images.firstWhere(
              (element) => int.parse(element.index) == index,
              orElse: () => Upload());
          return Row(
            children: [
              _CarreteImageElement(
                index: index,
                image: image.id.isNotEmpty ? image : Upload(content: ''),
              ),
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

// ignore: must_be_immutable
class _CarreteImageElement<T> extends StatefulWidget {
  _CarreteImageElement({Key? key, required this.index, required this.image})
      : super(key: key);

  final int index;
  Upload image;

  @override
  State<_CarreteImageElement> createState() => _CarreteImageElementState();
}

class _CarreteImageElementState extends State<_CarreteImageElement> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _sizeCard = _size.width * 0.17;
    final AdPageProvider adPageProvider = Provider.of<AdPageProvider>(context);
    return InkWell(
      onTap: () async {
        if (_image != null || widget.image.id.isNotEmpty) {
          HandlerImage.showImage(
              context: context,
              image: widget.image,
              images: adPageProvider.ad.images,
              index: widget.index.toString(),
              path: _image,
              onPressedDelete: () {
                final indexList = adPageProvider.ad.images.indexWhere(
                    (element) => element.index == widget.index.toString());
                adPageProvider.ad.images
                    .remove(adPageProvider.ad.images[indexList]);
                _image = null;
                widget.image = Upload();
                Navigator.pop(context);
                setState(() {});
              },
              onPressedModify: () async {
                _image = await HandlerImage.openImagePicker(
                    context: context,
                    images: adPageProvider.ad.images,
                    index: widget.index);
                widget.image = Upload();
                Navigator.pop(context);
                setState(() {});
              });
        } else {
          _image = await HandlerImage.openImagePicker(
              context: context,
              index: widget.index,
              images: adPageProvider.ad.images);
          setState(() {});
        }
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
          child: HandlerImage.getImage(
              imageExist: widget.image, imagePicked: _image)),
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
  const _InputVisible({Key? key, required this.visible}) : super(key: key);

  final bool visible;
  @override
  State<_InputVisible> createState() => _InputVisibleState();
}

class _InputVisibleState extends State<_InputVisible> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EditAdProvider editAdProvider = Provider.of<EditAdProvider>(context);
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
            initialLabelIndex: widget.visible ? 1 : 0,
            totalSwitches: 2,
            labels: const ['Desactivado', 'Activado'],
            radiusStyle: true,
            onToggle: (index) {
              editAdProvider.isVisible = !editAdProvider.isVisible;
            },
          ),
        ),
      ],
    );
  }
}
