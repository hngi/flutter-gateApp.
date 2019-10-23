import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/core/models/visitor.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';

class GateManService {

  static BaseOptions options = BaseOptions(
    baseUrl: Endpoint.baseUrl,
    responseType: ResponseType.plain,
    connectTimeout: CONNECT_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
    headers:{
      'Accept':'application/json'
    },
  );

  static Dio dio = Dio(options);

  static dynamic getAllVisitors({@required authToken,
}) async {
    var uri = Endpoint.showVisitors;
    options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
    try {
      Response response = await dio.get(uri);

      print(response.statusCode);
      print(response.data);

      return (response.statusCode == 400)
          ? ErrorType.invalid_credentials
              : (response.statusCode == 200)
                  ? json.decode(response.data)
                  : ErrorType.generic;
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        return ErrorType.network;
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        return ErrorType.timeout;
      } else {
        return ErrorType.generic;
      }
    }
  }

  static dynamic getAllRequests({@required authToken,
  }) async {
    var uri = Endpoint.showRequests;
    options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
    try {
      Response response = await dio.get(uri);

      return (response.statusCode == 400)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        return ErrorType.network;
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        return ErrorType.timeout;
      } else {
        return ErrorType.generic;
      }
    }
  }

  static Future<List<GatemanResidentVisitors>> allResidentVisitors({
    @required String authToken,
  }) async {
    String uri = Endpoint.showVisitors;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);

      if (!mapResponse.containsKey('visitor') ||
          mapResponse['visitor'].length == 0) {
        return [];
      }
      final items = mapResponse['visitor'].cast<Map<String, dynamic>>();
      List<GatemanResidentVisitors> listOfGatemanResidentRequests =
      items.map<GatemanResidentVisitors>((json) {
        return GatemanResidentVisitors.fromJson(json);
      }).toList();

      return listOfGatemanResidentRequests;
    } else {
      throw Exception('Failed to load internet');
    }
  }

}
