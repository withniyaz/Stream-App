// ignore_for_file: avoid_print

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import '../constants/app_constants.dart';

class ApiService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  //API GET METHOD
  Future<dynamic> get(String url) async {
    final String? token = await storage.read(key: "token");
    print('Hitting GET API ${Uri.parse(baseFullUrl + apiUrl + url)}');
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseFullUrl + apiUrl + url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token != null ? 'Bearer $token' : '',
      });
      responseJson = _response(response);
    } on SocketException {
      Map<String, dynamic> check = {
        "error": 'Something went wrong, Try again later'
      };
      return Response(jsonEncode(check), 503);
    }
    return responseJson;
  }

  //API POST METHOD
  Future<dynamic> post(String url, Object? body) async {
    final String? token = await storage.read(key: "token");
    print('Hitting POST API ${Uri.parse(baseFullUrl + apiUrl + url)}');
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseFullUrl + apiUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token != null ? 'Bearer $token' : '',
          },
          body: jsonEncode(body));
      responseJson = _response(response);
    } on SocketException {
      Map<String, dynamic> check = {
        "error": 'Something went wrong, Try again later'
      };
      return Response(jsonEncode(check), 503);
    }
    return responseJson;
  }

  //API PUT METHOD
  Future<dynamic> put(String url, Object? body) async {
    final String? token = await storage.read(key: "token");
    print('Hitting PUT API ${Uri.parse(baseFullUrl + apiUrl + url)}');
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(baseFullUrl + apiUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token != null ? 'Bearer $token' : '',
          },
          body: jsonEncode(body));
      responseJson = _response(response);
    } on SocketException {
      Map<String, dynamic> check = {
        "error": 'Something went wrong, Try again later'
      };
      return Response(jsonEncode(check), 503);
    }
    return responseJson;
  }

  //API DELETE METHOD
  Future<dynamic> delete(String url, {Object? body}) async {
    final String? token = await storage.read(key: "token");
    print('Hitting DELETE API ${Uri.parse(baseFullUrl + apiUrl + url)}');
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(baseFullUrl + apiUrl + url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body != null ? jsonEncode(body) : null);
      responseJson = _response(response);
    } on SocketException {
      Map<String, dynamic> check = {
        "error": 'Something went wrong, Try again later'
      };
      return Response(jsonEncode(check), 503);
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        return response;
      case 401:
        return response;
      case 403:
        return response;
      case 404:
        return response;
      case 409:
        return response;
      case 500:
        return response;
      case 503:
        return response;
      default:
      // throw FetchDataException(
      //     'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
