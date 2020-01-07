import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/core/models/gateman_residents_request.dart';
import 'package:xgateapp/core/models/request.dart';
import 'package:xgateapp/providers/gateman_visitors.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';

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
    connectTimeout: CONNECT_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
    // headers: headers,
  );

  static Dio dio = Dio(options);

  static getAllVisitors() async {
    var uri = Endpoint.showVisitors;
    try {
      Response response = await dio.get(uri);
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

  static getAllRequests({
    @required String authToken,
  }) async {
    var uri = Endpoint.showRequests;
    try {
      options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
      Dio dio = Dio(options);
      Response response = await dio.get(uri);
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

    print(response.statusCode);
    print(response.data);

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

  //Get Gateman requests
  static Future<List<GatemanResidentVisitors>> allResidentVisitors({
    @required String authToken,
  }) async {
    String uri = Endpoint.gateman + '/visitors';

    Options options = Options(
      contentType: 'application/json',
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

  //Gateman checkout visitors.
  // static Future<List<GatemanResidentVisitors>> checkVisitors({
  static Future<dynamic> checkVisitors({
    @required String authToken,
    @required String qrCode,
  }) async {
    String uri = Endpoint.gateman + '/checkout';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

     try {

    Response response = await dio.put(uri,data: {
      'qr_code': qrCode
    }, options: options);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 403) {
      //no permission
      return ErrorType.cannot_check_visitor;
    }


    if (response.statusCode == 202) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);

      if (!mapResponse.containsKey('Visitor details')) {
        return ErrorType.no_visitor_with_code;
      }
      final items = mapResponse['Visitor details'].cast<String, dynamic>();
      GatemanResidentVisitors visitor =GatemanResidentVisitors.fromJson(items);

      return visitor;
    }
  
    if(response.statusCode != 200 && response.statusCode != 202){
      print('Errrror ');
      return ErrorType.generic;
 } 
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

  //Gateman checkout visitors.
  static Future<dynamic> admitVisitor({
    @required String authToken,
    @required String qrCode,
  }) async {
    String uri = Endpoint.gateman + '/admit';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );
    try{

    Response response = await dio.put(uri,
    data: {
      'qr_code':qrCode
    }, options: options);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 202) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);

      if (!mapResponse.containsKey('Visitor details') ||
          mapResponse['Visitor details'].length == 0) {
        return [];
      }
      final item = mapResponse['Visitor details'];
      GatemanResidentVisitors visitorVerified = GatemanResidentVisitors.fromJson(item);
      return visitorVerified;
    }
    if (response.statusCode != 202) return ErrorType.cannot_check_visitor;
  }
  on DioError catch (exception) {
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
