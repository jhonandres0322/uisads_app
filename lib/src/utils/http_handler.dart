import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uisads_app/src/constants/env.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class HttpHandler {
  final String _baseUrl = Env.getEndpoint('dev');
  final Preferences _preferences = Preferences();
  late String token = _preferences.token.isNotEmpty ? _preferences.token : '' ;


  final Map<String, String> _headers = {
    'Content-type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'charset': 'utf-8'
  };

  String _getEndpoint(String endpoint) => _baseUrl + endpoint;

  Map<String, String> _getHeaders() {
    if (token.isNotEmpty) {
      Map<String, String> accessToken = {'access-token': token};
      _headers.addAll(accessToken);
      return _headers;
    }
    return _headers;
  }

  // ignore: unused_element
  Future<Map<String, dynamic>> getGet(String endpoint) async {
    Map<String, String> getHeaders = _getHeaders();
    String url = _getEndpoint(endpoint);
    final resp = await http.get(Uri.parse(url), headers: getHeaders);
    Map<String, dynamic> jsonDecode = json.decode(resp.body);
    int statusCode = resp.statusCode;
    Map<String, dynamic> msgError = errorHandler(jsonDecode, statusCode);
    if (msgError.isNotEmpty) {
      return msgError;
    }
    jsonDecode.addAll({"error": false});
    return jsonDecode;
  }

  // ignore: unused_element
  Future<Map<String, dynamic>> getPost(
      String endpoint, Map<String, dynamic> request) async {
    Map<String, String> getHeaders = _getHeaders();
    String url = _getEndpoint(endpoint);
    final resp = await http.post(Uri.parse(url), headers: getHeaders, body: request);
    Map<String, dynamic> jsonDecode = json.decode(resp.body);
    int statusCode = resp.statusCode;
    Map<String, dynamic> msgError = errorHandler(jsonDecode, statusCode);
    if (msgError.isNotEmpty) {
      return msgError;
    }
    jsonDecode.addAll({"error": false});
    return jsonDecode;
  }

  // ignore: unused_element
  Future<Map<String, dynamic>> getPut(
      String endpoint, Map<String, dynamic> request) async {
    Map<String, String> getHeaders = _getHeaders();
    String url = _getEndpoint(endpoint);
    final resp =
        await http.put(Uri.parse(url), headers: getHeaders, body: request);
    Map<String, dynamic> jsonDecode = json.decode(resp.body);
    int statusCode = resp.statusCode;
    Map<String, dynamic> msgError = errorHandler(jsonDecode, statusCode);
    if (msgError.isNotEmpty) {
      return msgError;
    }
    jsonDecode.addAll({"error": false});
    return jsonDecode;
  }

  // ignore: unused_element
  Future<Map<String, dynamic>> getDelete(String endpoint) async {
    Map<String, String> getHeaders = _getHeaders();
    String url = _getEndpoint(endpoint);
    final resp = await http.delete(Uri.parse(url), headers: getHeaders);
    Map<String, dynamic> jsonDecode = json.decode(resp.body);
    int statusCode = resp.statusCode;
    Map<String, dynamic> msgError = errorHandler(jsonDecode, statusCode);
    if (msgError.isNotEmpty) {
      return msgError;
    }
    jsonDecode.addAll({"error": false});
    return jsonDecode;
  }

  Map<String, dynamic> errorHandler(
    Map<String, dynamic> response, int statusCode) {
    if (statusCode > 399) {
      Map<String, dynamic> msgMap = {};
      if( response['errors'] is List ) {
        List errors = response['errors'];
        String msg = '';
        for (var i = 0; i < errors.length; i++) {
          msg += errors[i]['msg'] + "\n";
        }
        msgMap.addAll({"msg": msg, "error": true});
        return msgMap;
      } else {
        msgMap.addAll({"msg" : response['msg'], "error": true } );
        return msgMap;
      }

    }
    return {};
  }
}
