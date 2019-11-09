import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/models/service_provider.dart';
import 'package:xgateapp/utils/constants.dart';

class ServiceProviderService {
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
      headers: headers,
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

  //Get List of ServiceProviders
  static Future<List<ServiceProvider>> getAllServiceProviders({
    @required String authToken,
  }) async {
    String uri = Endpoint.serviceProvider;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);
      final items = mapResponse["data"].cast<Map<String, dynamic>>();
      List<ServiceProvider> listOfServiceProviders =
          items.map<ServiceProvider>((json) {
        return ServiceProvider.fromJson(json);
      }).toList();

      return listOfServiceProviders;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Get List of ServiceProviders
  static Future<List<ServiceProvider>> getServiceProvidersByCategoryID({
    @required String authToken,
    @required int categoryID,
  }) async {
    String uri = Endpoint.serviceProvider + '/category/$categoryID';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);
      final items = mapResponse["data"].cast<Map<String, dynamic>>();
      List<ServiceProvider> listOfServiceProviders =
          items.map<ServiceProvider>((json) {
        return ServiceProvider.fromJson(json);
      }).toList();

      return listOfServiceProviders;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      print(response.statusCode);
      print(response.data);
      throw Exception('Failed to load internet');
    }
  }

  //Get List of ServiceProviders
  static Future<ServiceProvider> getServiceProviderByID({
    @required String authToken,
    @required int categoryID,
  }) async {
    String uri = Endpoint.serviceProvider + '/$categoryID';

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      print(mapResponse);
      final items = mapResponse["data"];
      return ServiceProvider.fromJson(items);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //Get List of ServiceProviders
  static Future<List<ServiceProviderCategory>> getServiceProviderCategories({
    @required String authToken,
  }) async {
    String uri = Endpoint.serviceProviderCategory;

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
      final items = mapResponse["data"].cast<Map<String, dynamic>>();
      List<ServiceProviderCategory> listOfServiceProviderCategories =
          items.map<ServiceProviderCategory>((json) {
        return ServiceProviderCategory.fromJson(json);
      }).toList();

      return listOfServiceProviderCategories;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}
