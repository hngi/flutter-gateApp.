import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/core/models/gateman_residents_request.dart';
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

  //Get Gateman requests
  static Future<List<GatemanResidentRequest>> allRequests({
    @required String authToken,
  }) async {
    String uri = Endpoint.gatemanRequests;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);

      if (mapResponse.containsKey('total') && mapResponse['total'] == 0) {
        return [];
      }
      final items = mapResponse['residents'].cast<Map<String, dynamic>>();
      List<GatemanResidentRequest> listOfGatemanResidentRequests =
          items.map<GatemanResidentRequest>((json) {
        return GatemanResidentRequest.fromJson(json);
      }).toList();

      return listOfGatemanResidentRequests;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Accept a Request
  static acceptRequest({
    @required String authToken,
    @required int requestId,
  }) async {
    var uri = Endpoint.gatemanRequests + '/accept/$requestId';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    try {
      Response response = await dio.put(uri, options: options);

      print(response.statusCode);
      print(response.data);

      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
              : (response.statusCode == 200 || response.statusCode == 202)
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

  //Reject a Request
  static rejectRequest({
    @required String authToken,
    @required int requestId,
  }) async {
    var uri = Endpoint.gatemanRequests + '/reject/$requestId';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    try {
      Response response = await dio.put(uri, options: options);

      print(response.statusCode);
      print(response.data);

      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
              : (response.statusCode == 200 || response.statusCode == 202)
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
}
