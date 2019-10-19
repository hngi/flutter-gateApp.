import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/constants.dart' as prefix1;
import 'package:gateapp/utils/errors.dart';
import 'package:intl/intl.dart';

class VisitorService {
  static String authToken = '';

  static BuildContext context;

  static Future<String> getAuthToken() async {
    try {
      authToken = await prefix1.authToken(context);
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
    connectTimeout: prefix1.CONNECT_TIMEOUT,
    receiveTimeout: prefix1.RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
    headers: headers,
  );

  static Dio dio = Dio(options);

  static addVisitor({
    @required String name,
    @required DateFormat arrivalDate,
    @required String carPlateNo,
    @required String purpose,
    @required String status,
    @required String estateId,
  }) async {
    var uri = Endpoint.visitor;
    var data = {
      "name": name,
      "arrival_date": arrivalDate,
      "car_plate_no": carPlateNo,
      "purpose": purpose,
      "status": status,
      "home_id": estateId
    };
    try {
      Response response = await dio.post(uri, data: data);

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

  static editVisitor({
    @required String name,
    @required DateFormat arrivalDate,
    @required String carPlateNo,
    @required String purpose,
    @required String status,
    @required String estateId,
  }) async {
    BigInt id;
    var uri = Endpoint.visitor;
    var data = {
      "name": name,
      "arrival_date": arrivalDate,
      "car_plate_no": carPlateNo,
      "purpose": purpose,
      "status": status,
      "home_id": estateId
    };
    try {
      Response response = await dio.put(uri, data: data,
          queryParameters: {"id" : id});

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



  static deleteVisitor() async{
    BigInt id;
    var uri = Endpoint.visitor;
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
