import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/core/models/request.dart';
import 'package:gateapp/providers/gateman_visitors.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
import 'package:gateapp/utils/errors.dart';

class GatemanService {
  static String authToken;
  static BuildContext context;

  static Future<String> getAuthToken() async {
    try {
      authToken = await prefix0.authToken(context);
      return authToken;
    } catch (error) {
      throw error;
    }
  }

  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: authToken,
  };

  static BaseOptions options = BaseOptions(
    baseUrl: Endpoint.showVisitors,
    responseType: ResponseType.plain,
    connectTimeout: prefix0.CONNECT_TIMEOUT,
    receiveTimeout: prefix0.RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
    headers: headers,
  );

  static Dio dio = Dio(options);

  static getAllVisitors() async {
    var uri = Endpoint.showVisitors;
    try {
      Response response = await dio.get(uri);
      print(response.data);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
              : (response.statusCode == 200)
                  ? GatemanVisitors.fromJson(response.data)
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

  static getAllRequests() async {
    var uri = Endpoint.showRequests;
    try {
      Response response = await dio.get(uri);
      print(response.data);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? Requests.fromJson(response.data)
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
}
