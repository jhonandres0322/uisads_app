import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';

import 'package:uisads_app/src/constants/import_models.dart';

class HandlerImage  {

  static const double _maxWidth  = 400;
  static const double _maxHeight = 400;
  static final ImagePicker _imagePicker = ImagePicker();
  static const _pathImagePlaceholder = 'assets/images/jar-loading.gif';
  static const _pathNoImage = 'assets/images/no-image.png';

  static Future<String> getImageBase64( Upload image ) async {
    if( image.content.isNotEmpty ) {
      Uint8List bytes = base64.decode( image.content ); 
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File( "$dir/${image.name}");
      file.writeAsBytesSync( bytes );
      return file.path;
    }
    return '';
  }

  static String convertFileToBase64( String path ) {
    final imageBytes = File( path ).readAsBytesSync();
    final base64String =  base64Encode( imageBytes )  ;
    return base64String;
  }

  static Future<XFile?> openImagePicker({ 
    required BuildContext context, 
    required int index, 
    required List<Upload> images 
  }) async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery, 
      maxHeight: _maxHeight, 
      maxWidth: _maxWidth
    );
    if (pickedImage != null) {
      String content = '';
      content = convertFileToBase64(pickedImage.path);
      final Upload upload = Upload.fromMap({
        "content": content,
        "name": pickedImage.name,
        "type": pickedImage.name.split('.')[1],
        "index": index.toString()
      });
      final indexList = images.indexWhere( (element) {
        return element.index == index.toString();
      } );
      if (indexList >= 0) {
        images.remove( images[indexList] );
        images.add(upload);
      } else {
        images.add(upload);
      }
      return XFile(pickedImage.path);
      // setState(() {});
    }
    return null;
  }


  static Future<void> showImage( {
    required BuildContext context, 
    required XFile? path, 
    required List<Upload> images, 
    required String index,
    required Upload image,
    required Function onPressedModify,
    required Function onPressedDelete
  }) async {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: EdgeInsets.all(_size.height * 0.01),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all( color: AppColors.logoSchoolPrimary, width: 2 ),
            ),
            child: ClipRRect(
              child: HandlerImage.getImage(
                imageExist: image,
                imagePicked: path
              ),
              // child: Image.file( 
              //   File( path ), 
              //   fit: BoxFit.cover
              // ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                ElevatedButton(
                  child: const Text('Eliminar'),
                  style: ElevatedButton.styleFrom(
                    onPrimary: AppColors.reject,
                    primary: AppColors.mainThirdContrast,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: AppColors.reject)),
                  ),
                  onPressed: () {
                    onPressedDelete();
                  }, 
                ),
                ElevatedButton(
                  child: const Text('Modificar'),
                    onPressed: () {
                      onPressedModify();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors.mainThirdContrast,
                      primary: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: AppColors.primary)),
                    ),
                ),
                const SizedBox()
              ],
            )
          ],
        );
      }
    );
  }

  static Widget getImage({
    required Upload imageExist,
    required XFile? imagePicked
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      clipBehavior: Clip.hardEdge ,
      child: FutureBuilder<String>(
        future: HandlerImage.getImageBase64( imageExist ),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if( snapshot.hasData ) {
            String pathImage = snapshot.data!;
            if( pathImage.isNotEmpty ) {
              return Image.file( File( pathImage ), fit: BoxFit.cover);
            } else if ( imagePicked != null ) {
              return Image.file(File( imagePicked.path ), fit: BoxFit.cover);
            } else {
              return const FadeInImage(
                placeholder: AssetImage(_pathImagePlaceholder),
                image: AssetImage(_pathNoImage),
                fit: BoxFit.cover
              );
            }
          } else {
            return const Center( 
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
