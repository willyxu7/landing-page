import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kukerja_web/core/exceptions/bad_request_exception.dart';
import 'package:kukerja_web/core/exceptions/fetch_data_exception.dart';
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/exceptions/unauthorized_exception.dart';
import 'package:kukerja_web/env/prod_env.dart';

class APIHelper {

  late final FlutterSecureStorage _storage;

  APIHelper() {
    _storage = const FlutterSecureStorage();
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    Map<String, dynamic> responseJson;
    try {
      http.Response response =
      await http.get(Uri.parse(ProdEnv.apiURL + url), headers: {
        "Authorization": "Bearer ${await getAccessToken()}",
        ...?headers
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> post(String url, String body, {Map<String, String>? headers}) async {
    Map<String, dynamic> responseJson;
    try {
      http.Response response = await http.post(
          Uri.parse(ProdEnv.apiURL + url),
          headers: {
            "Authorization": "Bearer ${await getAccessToken()}",
            ...?headers
          },
          body: body
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  Future<dynamic> patch(String url, String body, {Map<String, String>? headers}) async {
    Map<String, dynamic> responseJson;
    try {
      http.Response response = await http.patch(
          Uri.parse(ProdEnv.apiURL + url),
          headers: {
            "Authorization": "Bearer ${await getAccessToken()}",
           ...?headers
          },
          body: body
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }

    return responseJson;
  }

  Map<String, dynamic> _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 201:
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 400:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
        throw InternalServerErrorException(response.statusCode, response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: "tokenIssue");
  }
}
