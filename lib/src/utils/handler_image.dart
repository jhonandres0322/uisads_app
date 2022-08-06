



import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uisads_app/src/models/upload.dart';

Future<String> getImageBase64( Upload image ) async {
  if( image.content.isNotEmpty ) {
    Uint8List bytes = base64.decode( image.content ); 
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File( "$dir/${image.name}");
    file.writeAsBytesSync( bytes );
    return file.path;
  }
  return '';
}

String convertFileToBase64( String path ) {
  final imageBytes = File( path ).readAsBytesSync();
  final base64String =  base64Encode( imageBytes )  ;
  return base64String;
}
