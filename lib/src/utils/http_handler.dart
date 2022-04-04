import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uisads_app/src/constants/env.dart';

// ignore: todo
// TODO: Cambiar por el token de preferences shared
String token = 'este es el token';

class HttpHandler {
  // ignore: non_constant_identifier_names
  String BASE_URL = Env().getEndpoint();
  Map<String, String> headers = {'Content-type': 'application/json'};

  Map<String, String> addTokenHeader(
      String token, Map<String, String> headers) {
    if (token.isNotEmpty) {
      Map<String, String> accessToken = {'access-token': token};
      headers.addAll(accessToken);
      return headers;
    }
    return headers;
  }

  Future<dynamic> getGet(String endpoint) async {
    Map<String, String> getHeaders = addTokenHeader(token, headers);
    final resp =
        await http.get(Uri.parse('$BASE_URL$endpoint'), headers: getHeaders);
    int statusCode = resp.statusCode;
    if ( statusCode < 200 || statusCode > 399 ) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }

  Future<dynamic> getPost(String endpoint, Map<String, dynamic> request) async {
    Map<String, String> postHeaders = addTokenHeader(token, headers);
    final resp = await http.post(Uri.parse('$BASE_URL$endpoint'),
        headers: postHeaders, body: request);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }

  Future<dynamic> getPut(String endpoint, Map<String, dynamic> request) async {
    Map<String, String> putHeaders = addTokenHeader(token, headers);
    final resp = await http.put(Uri.parse('$BASE_URL$endpoint'),
        headers: putHeaders, body: request);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }

  Future<dynamic> getDelete(String endpoint) async {
    Map<String, String> deleteHeaders = addTokenHeader(token, headers);
    final resp = await http.delete(Uri.parse('$BASE_URL$endpoint'),
        headers: deleteHeaders);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }
}
