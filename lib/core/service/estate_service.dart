import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';

class EstateService {
  // Setting up base url ann Dio
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

  static dynamic addEstate({
    @required String estate_name,
    @required String city,
    @required String country,
  }) async{
    try {
      var data = {
        "estate_name": estate_name,
        "city": city,
        "country": country,
      };

      print(data);

      Response response = await dio.post(
          Endpoint.addEstate,
        data: data,
      );

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 500) {
        print("500");
        return ErrorType.generic;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final responseJson = json.decode(response.data);
        print("400");
        return GateManHelpers.getErrorType(responseJson);
      } else {
        final responseJson = json.decode(response.data);
        print(response.data);
        return responseJson;
      }
    } on DioError catch (exception) {
      if (exception == null || exception.toString().contains('SocketException')) {
        print("Newtork issues");
        return ErrorType.network;
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        print("TIME OUT");
        return ErrorType.timeout;
      } else {
        print("TIME OUT 2");
        return ErrorType.timeout;
      }
    }
  }


}