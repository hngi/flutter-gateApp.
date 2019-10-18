import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileService {
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
      static Dio dio = Dio(options);
    
      
      static dynamic getCurrentUserProfile({@required authToken
      }) async {
        var uri = Endpoint.getCurrentUser;
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.get(uri);
    
          print(response.statusCode);
          print(response.data);
    
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

       static dynamic setCurrentUserProfile({
        @required String phone,@required String email,@required String name,@required authToken,
      }) async {
        print(authToken);
        var uri = Endpoint.editCurrentuser;
        options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(options);
        try {
          Response response = await dio.put(uri,data: {
            'name':name,
            'username':name,
            'email':email,
            'phone':phone,

          });
    
          print(response.statusCode);
          print(response.data);
    
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
