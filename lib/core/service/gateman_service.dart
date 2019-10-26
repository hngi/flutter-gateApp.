import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/core/models/gateman_resident_visitors.dart' as prefix1;
import 'package:gateapp/core/models/visitor.dart';
import 'package:gateapp/pages/residents.dart';
import 'package:gateapp/utils/constants.dart';

import 'package:gateapp/core/models/gateman_resident_visitors.dart';
import 'package:gateapp/core/models/gateman_residents_request.dart';
import 'package:gateapp/core/models/request.dart';
import 'package:gateapp/providers/gateman_visitors.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
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

  static Future<List<ResidentUser>> getAllRequests({
    @required authToken,
  }) async {
    var uri = Endpoint.showRequests;
    options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
    try {
      Response response = await dio.get(uri);
      //List<Resident> listOfRequests = [];

      List<ResidentUser> users = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.data);
        print(responseData);

        if (responseData['requests'] == 0 ||
            responseData['residents'].length == 0 ||
            !(responseData.containsKey('residents'))) {
          return [];
        }
        final data = responseData['residents'].cast<Map<String, dynamic>>();
        users = data
            .map<ResidentUser>((json) => ResidentUser.fromJson(json))
            .toList();
      }
      return users;

    } on DioError catch (exception) {
      throw exception;
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

  static Future<List<ResidentUser>> allRequests({
    @required String authToken,
  }) async {
    String uri = Endpoint.showRequests;

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
      List<ResidentUser> listOfGatemanResidentRequests =
      items.map<ResidentUser>((json) {
        return ResidentUser.fromJson(json);
      }).toList();

      return listOfGatemanResidentRequests;
    } else {
      throw Exception('Failed to load internet');
    }
  }

/*
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
*/

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

/*  //Get Gateman requests
  static Future<List<GatemanResidentVisitors>> allResidentVisitors({
    @required String authToken,
  }) async {
    String uri = Endpoint.gateman + '/visitors';

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
  }*/
}
