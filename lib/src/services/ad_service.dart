


import 'package:uisads_app/src/utils/http_handler.dart';

class AdService with HttpHandler {


  Future<Map<String,dynamic>> getCategories() async {
    final resp = await getGet('/category');
    return resp;
  }

}