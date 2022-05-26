import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uisads_app/src/constants/env.dart';
import 'package:uisads_app/src/widgets/alert_error.dart';

// ignore: todo
// TODO: Cambiar por el token de preferences shared
String token = 'este es el token';

class HttpHandler {
  // ignore: non_constant_identifier_names
  final String _baseUrl = Env().getEndpoint('dev');
  Map<String, String> headers = {
    'Content-type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'charset': 'utf-8'
  };

  Map<String, String> _addTokenHeader(
      String token, Map<String, String> headers) {
    if (token.isNotEmpty) {
      Map<String, String> accessToken = {'access-token': token};
      headers.addAll(accessToken);
      debugPrint(" headers --> $headers ");
      return headers;
    }
    return headers;
  }

  Future<dynamic> getGet(String endpoint) async {
    Map<String, String> getHeaders = _addTokenHeader(token, headers);
    final resp =
        await http.get(Uri.parse('$_baseUrl$endpoint'), headers: getHeaders);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }

  Future<dynamic> getPost(String endpoint, Map<String, dynamic> request) async {
    Map<String, String> postHeaders = _addTokenHeader(token, headers);
    final resp = await http.post(Uri.parse('$_baseUrl$endpoint'),
        headers: postHeaders, body: request);
    final decoded = json.decode( resp.body );
    log('decoded --> $decoded');
    return decoded;
  }

  Future<dynamic> getPut(String endpoint, Map<String, dynamic> request) async {
    Map<String, String> putHeaders = _addTokenHeader(token, headers);
    final resp = await http.put(Uri.parse('$_baseUrl$endpoint'),
        headers: putHeaders, body: request);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }

  Future<dynamic> getDelete(String endpoint) async {
    Map<String, String> deleteHeaders = _addTokenHeader(token, headers);
    final resp = await http.delete(Uri.parse('$_baseUrl$endpoint'),
        headers: deleteHeaders);
    int statusCode = resp.statusCode;
    if (statusCode < 200 || statusCode > 399) {
      throw Exception(statusCode);
    }
    return json.decode(resp.body);
  }
}
