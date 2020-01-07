import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/models/bill.dart';
import 'package:xgateapp/core/models/bill_item.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';

class BillService {
  static String authTokenStr = '';

  static BuildContext context;

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

  //get list of billable items
  static Future<List<BillItem>> getResidentBill({
    @required String authToken,
    @required int estateId,
  }) async {
    String uri = Endpoint.estateBill(estateId: estateId);

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      final items =
          mapResponse["data"]['billable_items'].cast<Map<String, dynamic>>();
      List<BillItem> listOfBills = items.map<BillItem>((json) {
        return BillItem.fromJson(json);
      }).toList();

      return listOfBills;
    } else {
      return [];
    }
  }

  //subscribe to a bill
  static subscribeToBill({
    @required String authToken,
    @required int billId,
  }) async {
    var uri = Endpoint.subscribeBill(billId: billId);

    Options options = Options(
      contentType: 'application/json',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    try {
      Response response = await dio.post(uri, options: options);

      print(response.statusCode);
      print(response.data);

      return (response.statusCode == 404)
          ? ErrorType.invalid_credentials
          : (response.statusCode == 401)
              ? ErrorType.account_not_confimrmed
              : (response.statusCode == 200 || response.statusCode == 201)
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

  //get list of subscribed / pending bills
  static Future<List<Bill>> getAllBills({
    @required String authToken,
  }) async {
    String uri = Endpoint.pendingBills;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      final items = mapResponse["data"].cast<Map<String, dynamic>>();
      List<Bill> listOfBills = items.map<Bill>((json) {
        return Bill.fromJson(json);
      }).toList();

      return listOfBills;
    } else {
      return [];
    }
  }

  //get list of subscribed / pending bills
  static Future<List<Bill>> getAllPaidBills({
    @required String authToken,
  }) async {
    String uri = Endpoint.paidBills;

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      final items = mapResponse["data"].cast<Map<String, dynamic>>();
      List<Bill> listOfBills = items.map<Bill>((json) {
        return Bill.fromJson(json);
      }).toList();

      return listOfBills;
    } else {
      return [];
    }
  }
}
