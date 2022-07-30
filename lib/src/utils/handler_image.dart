



import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uisads_app/src/models/upload.dart';

Future<String> getImageBase64( Upload image ) async {
  Uint8List bytes = base64.decode( image.content );
  String dir = (await getApplicationDocumentsDirectory()).path;
  String dateNow = DateTime.now().millisecondsSinceEpoch.toString(); 
  File file = File( "$dir/$dateNow.${image.type}");
  file.writeAsBytesSync( bytes );
  return file.path;
}

String convertFileToBase64( String path ) {
  final imageBytes = File( path ).readAsBytesSync();
  final base64String =  base64Encode( imageBytes )  ;
  return base64String;
}
