import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/providers/category_provider.dart';
import 'package:uisads_app/src/providers/create_ad_provider.dart';
import 'package:uisads_app/src/services/ad_service.dart';
import 'package:uisads_app/src/utils/handler_image.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/alert_custom.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/input_custom.dart';
import 'package:uisads_app/src/widgets/list_category.dart';

class CreateAdPage extends StatelessWidget {
  const CreateAdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CreateAdProvider createAdProvider =
        Provider.of<CreateAdProvider>(context, listen: false);
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        categoryProvider.categorySelect = '';
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: AppColors.mainThirdContrast,
              elevation: 10.0,
              title: const Text(
                'Crear Anuncio',
                style: TextStyle(color: AppColors.subtitles),
              ),
              actions: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    child: const Text('Publicar'),
                    onPressed: () {
                      if (categoryProvider.categorySelect == '') {
                        ScaffoldMessenger.of(context).showSnackBar(showAlertCustom("Por favor seleccione una categoria, si no encuentra la suya seleccione Variados", true));
                      } else {
                        createAdProvider.formKey.currentState?.save();
                        createAdProvider.category =
                            categoryProvider.categorySelect;
                        Ad adRequest = createAdProvider.handlerData();
                        _createAd(context, adRequest);
                        createAdProvider.limpiarObjetos();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors.mainThirdContrast,
                      primary: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                )
              ]),
          bottomNavigationBar: const BottomNavigatonBarUisAds(),
          body: SingleChildScrollView(
            child: Container(
              child: const FormCreateAd(),
            ),
          )),
    );
  }

  void _createAd(BuildContext context, Ad adRequest) async {
    final adService = AdService();
    final CategoryProvider _categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final response = await adService.createAd(adRequest);
    ScaffoldMessenger.of(context)
        .showSnackBar(showAlertCustom(response.message, response.error));
    Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
    _categoryProvider.categorySelect = '';
  }
}

class FormCreateAd extends StatelessWidget {
  const FormCreateAd({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final formKey = _createAdProvider.formKey;
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Form(
          key: formKey,
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
          )),
    );
  }
}

class _InputTitle extends StatelessWidget {
  const _InputTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final Widget inputTitle = TextFormField(
        autofocus: false,
        obscureText: false,
        keyboardType: TextInputType.text,
        onSaved: (value) => _createAdProvider.title = value ?? '',
        decoration: decorationInputCustom(Icons.abc, 'Pon aqui el titulo'));
    return InputCustom(labelText: '', input: inputTitle);
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createAdProvider = Provider.of<CreateAdProvider>(context);
    final Widget inputDescription = TextFormField(
        autofocus: false,
        obscureText: false,
        keyboardType: TextInputType.multiline,
        onSaved: (value) => _createAdProvider.description = value ?? '',
        maxLines: 6,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            hintText: 'Describe tu anuncio!',
            hintStyle: const TextStyle(
              fontSize: 13.0,
              color: AppColors.subtitles,
            ),
            prefixIconColor: AppColors.primary,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5))));
    return InputCustom(labelText: 'Descripción', input: inputDescription);
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
  final _picker = ImagePicker();
  final _pathImagePlaceholder = 'assets/images/jar-loading.gif';
  final _pathNoImage = 'assets/images/no-image.png';

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _sizeCard = _size.width * 0.17;
    return InkWell(
      onTap: () {
        if (_image != null) {
          _showImage(context);
        } else {
          _openImagePicker(context);
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

  /// Abre el dialogo para seleccionar una imagen de la galeria .
  Future<void> _openImagePicker(BuildContext context) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 350, maxWidth: 350);

    int index = widget.index;
    final CreateAdProvider createAdProvider =
        Provider.of<CreateAdProvider>(context, listen: false);
    if (pickedImage != null) {
      String content = '';
      content = convertFileToBase64(pickedImage.path);
      final Upload upload = Upload.fromMap({
        "content": content,
        "name": pickedImage.name,
        "type": pickedImage.name.split('.')[1],
        "index": index.toString()
      });
      final indexList = createAdProvider.images
          .indexWhere((element) => element.index == index);
      if (indexList >= 0) {
        createAdProvider.images.remove(createAdProvider.images[indexList]);
        createAdProvider.images.add(upload);
      } else {
        createAdProvider.images.add(upload);
      }
      setState(() {
        _image = XFile(pickedImage.path);
      });
    }
  }

  Future<void> _showImage(BuildContext context) async {
    final Size _size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            title: Row(
              children: [
                const Expanded(child: SizedBox()),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(_size.height * 0.01),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: AppColors.logoSchoolPrimary,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                child: Image.file(File(_image!.path), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors.reject,
                      primary: AppColors.mainThirdContrast,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: AppColors.reject)),
                    ),
                    onPressed: () {
                      // Eliminar la imagen del carrete y del provider.
                      final CreateAdProvider createAdProvider = Provider.of<CreateAdProvider>(context, listen: false);
                      final indexList = createAdProvider.images.indexWhere((element) => element.index == widget.index.toString());
                      createAdProvider.images.remove(createAdProvider.images[indexList]);

                      setState(() {
                        _image = null;
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Eliminar'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _openImagePicker(context);
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.mainThirdContrast,
                        primary: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(color: AppColors.primary)),
                      ),
                      child: const Text('Modificar')),
                  const SizedBox()
                ],
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
