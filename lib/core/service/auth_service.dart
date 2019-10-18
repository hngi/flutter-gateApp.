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
class AuthService {
  static String deviceId = 'as2563ab';

  
  static Future<String> getDeviceId() async{
    try{
    deviceId = await FlutterUdid.udid;
    print(deviceId);
    return deviceId;
    } catch (error){
      throw error;
    }

  }



  


 
    
      static BaseOptions options = BaseOptions(
          baseUrl: Endpoint.baseUrl,
          responseType: ResponseType.plain,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          validateStatus: (code) {
            if (code >= 200) {
              return true;
            }
            return false;
          });
      static Dio dio = Dio(options);
    
      //Sign IN a User
      static dynamic loginUser({
        @required String phone,
      }) async {
        var uri = Endpoint.login;
    
        try {
          Response response = await dio.post(uri, data: {
            "phone": phone,
            "device_id": await getDeviceId()
          });
    
          print(response.statusCode);
          print(response.data);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode == 500) return ErrorType.generic;
          if (response.statusCode == 404) return ErrorType.invalid_credentials;
          if (response.statusCode == 401) return ErrorType.account_not_confimrmed;
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
    
      //Register a new User
      static dynamic registerUser({
        @required String name,
        // @required String lastName,
        @required String email,
        @required String phone,
        @required user_type userType,
        // @required String password,
        // @required String passwordConfirmation,
      }) async {
        var uri = userType == user_type.ADMIN
            ? Endpoint.adminRegister
            : userType == user_type.GATEMAN
                ? Endpoint.gatemanRegister
                : Endpoint.residentRegister;
    
        try {
          Options options = Options(
            contentType: ContentType.parse('application/json'),
          );
          //await getDeviceId();;
          print(deviceId);
          
          print('vvvvvvvvvvvvvv');
          print([name,email,phone,deviceId].join(' '));
          var data = {
                "name": name,
                "email": email,
                "phone": phone,
                "device_id": await getDeviceId()};//

          print(data);
          Response response = await dio.post(uri,
              data: data,
              options: options);
    
          print(response.data);
    
          if (response.statusCode == 500) {
            return ErrorType.generic;
          } else if (response.statusCode == 400 || response.statusCode == 401) {
            final responseJson = json.decode(response.data);
            return GateManHelpers.getErrorType(responseJson);
          } else {
            final responseJson = json.decode(response.data);
            return responseJson;
          }
        } on DioError catch (exception) {
          if (exception == null ||
              exception.toString().contains('SocketException')) {
            return ErrorType.network;
          } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
              exception.type == DioErrorType.CONNECT_TIMEOUT) {
            return ErrorType.timeout;
          } else {
            return ErrorType.timeout;
          }
        }
      }
    
      static dynamic verifyAccount({
        @required String verificationCode,
      }) async {
        var uri = Endpoint.verifyAccount;
    
        try {
          Response response = await dio.post(uri, data: {
            "verifycode": verificationCode,
            "device_id": await getDeviceId()
          });
    
          print(response.statusCode);
          print(response.data);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode == 500) return ErrorType.generic;
          if (response.statusCode == 401) return ErrorType.verify_code_not_found;
          if (response.statusCode == 200) return json.decode(response.data);
          if (response.statusCode == 208) return ErrorType.account_already_verified;
          if (response.statusCode == 404) return ErrorType.verify_code_not_found;
          
    
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
    
      static dynamic sendPasswordRecoveryCode({
        @required String email,
      }) async {
        var uri = Endpoint.passwordVerify;
    
        try {
          Response response = await dio.post(uri, data: {
            "email": email,
          });
    
          print(response.statusCode);
          print(response.data);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode == 500) return ErrorType.generic;
          if (response.statusCode == 404) return ErrorType.email_not_found;
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
    
      static dynamic passwordReset({
        @required String verificationCode,
        @required String password,
        @required String passowrdConfirmation,
      }) async {
        var uri = Endpoint.passwordReset;
    
        try {
          Response response = await dio.put(uri, data: {
            "verifycode": verificationCode,
            "password": password,
            "password_confirmation": passowrdConfirmation,
          });
    
          print(response.statusCode);
          print(response.data);
    
          if (response == null) return ErrorType.generic;
          if (response.statusCode == 500) return ErrorType.generic;
          if (response.statusCode == 422) {
            final responseJson = json.decode(response.data);
            return GateManHelpers.getErrorType(responseJson);
          }
          if (response.statusCode == 404) return ErrorType.invalid_credentials;
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
