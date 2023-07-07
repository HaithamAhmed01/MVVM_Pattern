import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/failures.dart';
import '../network/network_info.dart';

class Api {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';

  final NetWorkInfo networkInformation;
  final Dio _dio;

  Api(this.networkInformation, this._dio);

  Future<Response> get({
    required String endPoint,
    userToken,
    String? lang,
  }) async {
    log('Calling $_baseUrl$endPoint , with token $userToken');
    Map<String, dynamic> headers = {};
    headers.addAll({'Accept': 'application/json'});
    if (userToken != null) {
      headers.addAll({'Authorization': 'Bearer $userToken'});
    }
    if (lang != null) {
      headers.addAll({'Accept-Language': lang});
    }
    await checkConnectivity();
    var response = await _dio.get('$_baseUrl$endPoint',
        options: Options(headers: headers));

    return response;
  }

  Future<Response> post({
    required endPoint,
    @required dynamic body,
    String? bearerToken,
  }) async {
    log('Calling $_baseUrl$endPoint with body $body  and bearerToken = $bearerToken');

    Map<String, dynamic> headers = {};
    headers.addAll({'accept': 'application/json'});

    if (bearerToken != null) {
      headers.addAll({
        'Authorization': 'Bearer $bearerToken',
      });
    }
    await checkConnectivity();
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      options: Options(headers: headers),
      data: FormData.fromMap(body),
    );

    log(response.data.toString());
    return response;
  }

  Future<Response> put(
      {required String endUrl, dynamic body, String? bearerToken}) async {
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
    };
    if (bearerToken != null) {
      headers.addAll({'Authorization': 'Bearer $bearerToken'});
    }
    await checkConnectivity();

    var response = await _dio.put(
      "$_baseUrl$endUrl",
      data: FormData.fromMap(body),
      options: Options(
          headers: headers, contentType: Headers.formUrlEncodedContentType),
    );

    return response;
  }

  Future<ServerFailure> checkConnectivity() async {
    bool isConnected = await networkInformation.isConnected;
    if (!isConnected) {
      return ServerFailure(ResponseMessage.NO_INTERNET_CONNECTION);
    }
    return ServerFailure(ResponseMessage.NO_INTERNET_CONNECTION);
  }
}
