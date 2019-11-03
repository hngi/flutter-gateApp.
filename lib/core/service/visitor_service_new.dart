import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:http_parser/http_parser.dart';
class NewVisitorService {
  static BaseOptions options = BaseOptions(
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers:{
        'Accept':'application/json',
        'Content-Type': 'multipart/form-data'
      },
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      });
  //static Dio dio = Dio(options);


  static String qr_code='';
  static dynamic addVisitor({@required String name,
    @required String arrivalDate,
    @required String carPlateNo,
    @required String purpose,
    @required String phone,
    @required String status,
    @required String estateId,
    @required String authToken,
    @required String visitingPeriod,
    @required String description,
    File image, String visitorsGroup
  }) async {
    print('prrrrrrrr');
    print(arrivalDate);

    var uri = Endpoint.visitor;
    print(authToken);
    Future<FormData> formData1() async {
      print(name);
      print(phone);
    FormData data = FormData.fromMap(
      {
      "name": name??'',
      "arrival_date": arrivalDate??'',
      "car_plate_no": carPlateNo??'',
      "purpose": purpose??'',
      "phone_no": phone,
      "status": status??'',
      "home_id": estateId??'',
      'visiting_period': visitingPeriod??'',
      'visitor_group': visitorsGroup??'none',
      'description':description??''
      
    }
    );
if(image!=null){
   data.files.add(MapEntry("image",await MultipartFile.fromFile(
        image.path,
        filename:basename(image.path),
        contentType: MediaType.parse('application/octet-stream'))));
} 
    print(data.files);
    return data;
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
    print(formOption.headers);
    Dio dio = Dio(formOption);
    try {

      
      Response response = await dio.post(uri,data: await formData1());

      print(response.data);

    

      if (response == null) return ErrorType.generic;
      if (response.statusCode != 200 /*|| response.statusCode !=201*/) return ErrorType.generic;
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



   static dynamic updateVisitor({@required String name,
    @required String arrivalDate,
    @required String carPlateNo,
    @required String purpose,
    @required String phone,
    @required String status,
    @required String estateId,
    @required String authToken,
    @required String visitingPeriod,
    @required String description,
    String visitorsGroup,
    @required int visitorId,
    File image
  }) async {
    print('prrrrrrrr');
    print(arrivalDate);

    var uri = Endpoint.editVisitor(visitorId: visitorId);
    print(authToken);
    Future<FormData> formData1() async {
      print(name);
      print(phone);
    FormData data = FormData.fromMap(
      {
      "name": name??'',
      "arrival_date": arrivalDate??'',
      "car_plate_no": carPlateNo.isEmpty?null:carPlateNo,
      "purpose": purpose??'',
      "phone_no": phone,
      "status": status??'',
      "home_id": estateId??'',
      'visitor_group': visitorsGroup??'none',
      'description':description??''
      
    }
    );
if(image!=null){
   data.files.add(MapEntry("image",await MultipartFile.fromFile(
        image.path,
        filename:basename(image.path),
        contentType: MediaType.parse('application/octet-stream'))));
} 
    print(data.files);
    return data;
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
    print(formOption.headers);
    Dio dio = Dio(formOption);
    try {

      
      Response response = await dio.post(uri,data: await formData1());


      print(response.statusCode);
      print(response.data);

    

      if (response == null) return ErrorType.generic;
      if (response.statusCode != 200 /*|| response.statusCode !=201*/) return ErrorType.generic;
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



  static dynamic getQrImageSrcForVisitor({
    @required String authToken, @required int visitorId

  })async{
    BaseOptions options = BaseOptions(
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
    String uri = Endpoint.getQRImageSrc(visitorId);
    Dio dio = new Dio(options);
    try{

            print('$visitorId :::::::::::::::::::::;;');
            Response response = await dio.get(uri);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode >= 500 && response.statusCode <= 509) return ErrorType.server;
      if(response.statusCode != 200) return ErrorType.generic;
      if(response.statusCode == 200) return json.decode(response.data);

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
