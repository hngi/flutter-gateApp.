import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
class NewVisitorService {
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


  static String qr_code='';
  static dynamic addVisitor({@required String name,
    @required String arrivalDate,
    @required String carPlateNo,
    @required String purpose,
    @required String status,
    @required String estateId,
    @required String authToken,
    File image
  }) async {
    var uri = Endpoint.visitor;
   

    
    Future<FormData> formData1() async {
      print(name);
    FormData data = FormData.fromMap(
      {
      "name": name??'',
      "arrival_date": arrivalDate??'',
      "car_plate_no": carPlateNo??'',
      "purpose": purpose??'',
      "status": status??'',
      "home_id": estateId??'',
      "image": await MultipartFile.fromFile(
        image.path,
        filename:basename(image.path),
        contentType: MediaType.parse('application/octet-stream')),
    }
    );
    print(data.fields);
    return data;
    }

  
  
    options.headers['Authorization'] = 'Bearer' + ' ' + authToken;
    options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    Dio dio = Dio(options);
    try {
      Response response = await dio.post(uri,data: await formData1());

      print(response.statusCode);
      print(response.data);
      final resp=json.decode(response.data);
      qr_code=resp['qr_image_src'];
      print('QR Code :'+qr_code);

      if (response == null) return ErrorType.generic;
      if (response.statusCode != 200) return ErrorType.generic;
      if (response.statusCode == 200) return json.decode(response.data);

      // }
    } on DioError catch (exception) {
      throw exception;
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
