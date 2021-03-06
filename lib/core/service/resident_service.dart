import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
class ResidentsGatemanRelatedService {
static BaseOptions options = BaseOptions(
          baseUrl: Endpoint.baseUrl,
          responseType: ResponseType.plain,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers:{
            'Accept':'application/json'
          },
          validateStatus: (code) {
            if (code >= 200) {
              return true;
            }
            return false;
          });
      static dynamic addGateman({@required String authToken,
      @required int gatemanId
      }) async {
        var uri = Endpoint.addGateMan(gatemanId: gatemanId);
      options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.post(uri);
    
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 405) return ErrorType.request_already_sent_to_gateman;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
          // }
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

       static dynamic findGateManByPhone({
        @required String phone,@required authToken, gatemanId,
      }) async {
        var uri = Endpoint.searchGatemanByPhone(gatemanPhone: phone);
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.get(uri);
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 404) return ErrorType.no_gateman_found;
          if (response.statusCode != 200) return ErrorType.generic;
          if(response.statusCode == 405) return ErrorType.request_already_sent_to_gateman;
          if (response.statusCode == 200) return json.decode(response.data);
    
          // }
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
    
    static dynamic findGateManByName({
        @required String name,@required authToken,
      }) async {
        var uri = Endpoint.searchGatemanByName(gatemanName: name);
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.get(uri);
          if (response == null) return ErrorType.generic;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
    
          // }
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


      static dynamic getGateManThatAccepted({@required authToken,
      }) async {
        var uri = Endpoint.viewGatemanThatAccepted;
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.get(uri);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
    
          // }
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
    
    static dynamic getGateManThatArePending({@required authToken,
      }) async {
        var uri = Endpoint.viewGatemanYetToAccept;
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.get(uri);
          if (response == null) return ErrorType.generic;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
    
          // }
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


      static dynamic removeGateman({@required authToken,
      @required int gatemanId
      }) async {
        var uri = Endpoint.deleteGateman(gatemanId: gatemanId);
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.delete(uri);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
    
          // }
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
