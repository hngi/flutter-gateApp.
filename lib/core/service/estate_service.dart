import 'dart:convert';
import 'dart:core' as prefix1;
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
import 'package:gateapp/utils/errors.dart';

class EstateService {
  //static String deviceId = '';
  static String authToken = '';

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
    baseUrl: Endpoint.baseUrl,
    responseType: ResponseType.plain,
    connectTimeout: prefix0.CONNECT_TIMEOUT,
    receiveTimeout: prefix0.RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
    headers: headers,
  );

  static Dio dio = Dio(options);

  static addEstate({
    @required String estateName,
    @required String city,
    @required String country,
  }) async {
    var uri = Endpoint.estate;
    try {
      Response response = await dio.post(uri,
          data: {"estate_name": estateName, "city": city, "country": country});

      print(response.statusCode);
      print(response.data);

      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
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

  static getAllEstates() async {
    var uri = Endpoint.estates;
    try {
      Response response = await dio.get(uri);
      print(response.data);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
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

  static getEstateById() async{
    BigInt id;
    var uri = Endpoint.estate;
    try{
      Response response = await dio.get(uri, queryParameters: {"estate_id" : id});
      print(response.data);
      print(response.statusCode);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    }on DioError catch (exception) {
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

  static getEstateByName() async{
    String name;
    var uri = Endpoint.estate;
    try{
      Response response = await dio.get(uri, queryParameters: {"estate_name" : name});
      print(response.data);
      print(response.statusCode);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    }on DioError catch (exception) {
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

  static getEstateByCity() async{
    String city;
    var uri = Endpoint.getEstateByCity;
    try{
      Response response = await dio.get(uri, queryParameters: {"city" : city});
      print(response.data);
      print(response.statusCode);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    }on DioError catch (exception) {
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

  static getEstateByCountry() async{
    String country;
    var uri = Endpoint.getEstateByCountry;
    try{
      Response response = await dio.get(uri, queryParameters: {"country" : country});
      print(response.data);
      print(response.statusCode);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    }on DioError catch (exception) {
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

  static deleteEstateById() async{
    BigInt id;
    var uri = Endpoint.deleteEstate;
    try{
      Response response = await dio.delete(uri, queryParameters: {"id" : id});
      print(response.statusCode);
      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
          ? ErrorType.account_not_confimrmed
          : (response.statusCode == 200)
          ? json.decode(response.data)
          : ErrorType.generic;
    }on DioError catch (exception) {
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