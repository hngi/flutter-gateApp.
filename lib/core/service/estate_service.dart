import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/core/models/estate.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gateapp/utils/constants.dart';

class EstateService {
  //static String deviceId = '';
  static String authTokenStr = '';

  static BuildContext context;

  static Future<String> getAuthToken() async {
    try {
      String authTokenStr = await authToken(context);
      return authTokenStr;
    } catch (error) {
      print('unknown error occured while getting authtoken');
    }
  }

  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: authTokenStr,
  };

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

  //Get Authorization Token
  static String getAuth() {
    String token = '';
    getPrefs.then((prefs) => token = prefs.getString('authToken'));
    return token;
    // return prefs.getString('authToken');
  }

  //Add new Estate
  static addEstate({
    @required String estateName,
    @required String city,
    @required String country,
    @required String address,
  }) async {
    var uri = Endpoint.estate;

    try {
      Response response = await dio.post(uri, data: {
        "estate_name": estateName,
        "city": city,
        "country": country,
        "address": address,
      });

      print(response.statusCode);
      print(response.data);

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

  //Get List of Estates
  static Future<List<Estate>> getAllEstates({
    @required String authToken,
  }) async {
    String uri = Endpoint.estate + 's';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);
      final items = mapResponse["estates"].cast<Map<String, dynamic>>();
      List<Estate> listOfEstates = items.map<Estate>((json) {
        return Estate.fromJson(json);
      }).toList();

      return listOfEstates;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Get List of Estates by Country
  static Future<List<Estate>> getEstatesByCountry({
    @required String authToken,
    @required String country,
  }) async {
    String uri = Endpoint.estate + '/bycountry/' + country;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      // Map<String, dynamic> mapResponse = json.decode(response.data);
      var mapResponse = json.decode(response.data);
      print(mapResponse);
      // final items = mapResponse[].cast<Map<String, dynamic>>();
      List<Estate> listOfEstates = mapResponse.map<Estate>((json) {
        return Estate.fromJson(json);
      }).toList();

      return listOfEstates;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Get List of Estates by City
  static Future<List<Estate>> getEstatesByCity({
    @required String authToken,
    @required String city,
  }) async {
    String uri = Endpoint.estate + '/bycity/' + city;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      // Map<String, dynamic> mapResponse = json.decode(response.data);
      var mapResponse = json.decode(response.data);
      print(mapResponse);
      // final items = mapResponse[].cast<Map<String, dynamic>>();
      List<Estate> listOfEstates = mapResponse.map<Estate>((json) {
        return Estate.fromJson(json);
      }).toList();

      return listOfEstates;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Get an Estate by ID
  static Future<Estate> getAnEstatesByID({
    @required String authToken,
    @required int estateId,
  }) async {
    String uri = Endpoint.estate + '/$estateId';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      // Map<String, dynamic> mapResponse = json.decode(response.data);
      var mapResponse = json.decode(response.data);
      print(mapResponse);

      return mapResponse.first;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //delete an estate
  static Future<bool> deleteEstate({
    @required String estateId,
    @required String country,
  }) async {
    var uri = Endpoint.estate + '/delete/' + estateId;

    try {
      Response response = await dio.delete(uri);

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (exception) {
      print(exception);
      return false;
    }
  }

  //Add new Estate
  static Future selectEstate({
    @required int estateId,
    @required String authToken,
    houseBlock
  }) async {
    var uri = Endpoint.estate + '/choose/$estateId';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    try {
      Response response;
      if(houseBlock==null){
      response = await dio.post(uri, options: options);
      } else {
      response = await dio.post(uri,data:{'house_block':houseBlock}, options: options);
      }

      print(response.statusCode);
      print(response.data);

      // if (response == null) return ErrorType.generic;
      // if (response.statusCode == 500) return ErrorType.generic;
      // if (response.statusCode == 400 || response.statusCode == 401) {
      //   final responseJson = json.decode(response.data);
      //   return GateManHelpers.getErrorType(responseJson);
      // }
      if (response.statusCode == 200) return json.decode(response.data);
      if(response.statusCode >=500 && response.statusCode < 600) return false;

      return false;

      // }
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        return false;
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        return false;
      } else {
        return false;
      }
    }
  }

  //Search Estates
  static Future<List<Estate>> searchEstates({
    @required String authToken,
    @required String query,
  }) async {
    String uri = Endpoint.estate + '/search/$query';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);
      final items = mapResponse["estates"].cast<Map<String, dynamic>>();
      List<Estate> listOfEstates = items.map<Estate>((json) {
        return Estate.fromJson(json);
      }).toList();

      return listOfEstates;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}
