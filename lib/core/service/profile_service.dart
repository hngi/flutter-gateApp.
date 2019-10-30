import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:http_parser/http_parser.dart';
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
   
    
          if (response == null) return ErrorType.generic;
          if(response.statusCode == 422) return ErrorType.username_at_least_2_char;
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

       static dynamic setCurrentUserProfile({
        @required String phone,@required String email,@required String name,@required authToken,
        File image
      }) async {
        print(authToken);
        var uri = Endpoint.editCurrentuser;
        FormData data = FormData.fromMap(
      {
      "name": name,
      "phone":phone,
      "email":email,
 }
    );
if(image!=null){
  print(image.path);
   data.files.add(MapEntry("image",await MultipartFile.fromFile(
        image.path,
        filename:basename(image.path),
        contentType: MediaType.parse('application/octet-stream'))));
} 
BaseOptions formOption = BaseOptions(
      
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $authToken',
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      }

    );
       // options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
        Dio dio = Dio(formOption);
        try {
          Response response = await dio.post(uri,data: data);
    
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
