import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:http_parser/http_parser.dart';

class ResidentNotificationService {

  static deleteNotification({String authToken, String notificationId})async{
    BaseOptions option = BaseOptions(
      
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Authorization': 'Bearer $authToken',
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      }

    );
    String uri = Endpoint.baseUrl + Endpoint.deleteNotification(notificationId: notificationId);

    Dio dio = new Dio(option);
        try {
          Response response = await dio.delete(uri);
          //print(response.data);
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 400) return ErrorType.invalid_credentials;
          if (response.statusCode != 200) return ErrorType.generic;
          if (response.statusCode == 200) return json.decode(response.data);
    
          
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


  



  static getAllNotifications({String authToken})async{
    String uri = Endpoint.allNotifications;
    BaseOptions formOption = BaseOptions(
      
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Authorization': 'Bearer $authToken',
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      }

    );
    Dio dio = Dio(formOption);
    try {
          Response response = await dio.get(uri);
          print(response.data);
          print(response.statusCode);
    
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 400) return ErrorType.invalid_credentials;
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

  static markNotificationAsRead({String authToken,String notificationId})async{

    BaseOptions option = BaseOptions(
      
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Authorization': 'Bearer $authToken',
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      }

    );
    String uri = Endpoint.markNotificationAsRead(notificationId: notificationId);


     Dio dio = Dio(option);
    try {
          Response response = await dio.patch(uri);
    
          
    
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 400) return ErrorType.invalid_credentials;
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

  
static markselectedNotificationAsRead({String authToken,List<String> notificationIds})async{

    BaseOptions option = BaseOptions(
      
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Authorization': 'Bearer $authToken',
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      }

    );
    String uri = Endpoint.markSelectedNotificationAsRead(notificationIds: notificationIds);


     Dio dio = Dio(option);
    try {
          Response response = await dio.patch(uri);
    
          //print(response.statusCode);
          //print(json.decode(response.data));
    
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 400) return ErrorType.invalid_credentials;
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