import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/models/payment.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';

class PaymentService {
  static BaseOptions options = BaseOptions(
      baseUrl: Endpoint.baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers: {'Accept': 'application/json'},
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
        return false;
      });
  static Dio dio = Dio(options);

  static dynamic payBillWithCard(
      {@required String authToken,
      @required String cardNo,
      @required String cvv,
      @required String expiryyear,
      @required String expirymonth,
      @required String country,
      @required String currency,
      @required int amount,
      @required String email,
      @required String billId}) async {
    var uri = Endpoint.payWithCard;
    print(options.baseUrl + uri);
    options.headers['Authorization'] = 'Bearer $authToken';
    Dio dio = Dio(options);
    try {
      Map data = {
        "cardno": cardNo,
        "cvv": cvv,
        "expiryyear": expiryyear,
        "expirymonth": expirymonth,
        "country": country,
        "currency": currency,
        "amount": amount.toString(),
        "email": email,
        "bill_id": billId
      };
      print(data);
      Response response = await dio.post(uri, data: data);

      print(response.data);

      if (response == null) return ErrorType.generic;
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

  static dynamic insertCardPin({
    @required String authToken,
    @required String cardNo,
    @required String cvv,
    @required String expiryyear,
    @required String expirymonth,
    @required String country,
    @required String currency,
    @required int amount,
    @required String email,
    @required String pin,
  }) async {
    var uri = Endpoint.insertCardPin;
    print(options.baseUrl + uri);
    options.headers['Authorization'] = 'Bearer $authToken';
    Dio dio = Dio(options);
    try {
      Map data = {
        "cardno": cardNo,
        "cvv": cvv,
        "expiryyear": expiryyear,
        "expirymonth": expirymonth,
        "country": country,
        "currency": currency,
        "amount": amount.toString(),
        "email": email,
        "suggested_auth": "PIN",
        "pin": pin
      };
      print(data);
      Response response = await dio.post(uri, data: data);

      print(response.data);

      if (response == null) return ErrorType.generic;
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

  static dynamic otpConfirmation({
    @required String authToken,
    @required String transactionReference,
    @required String otp,
  }) async {
    var uri = Endpoint.otpConfirmation;
    print(options.baseUrl + uri);
    options.headers['Authorization'] = 'Bearer $authToken';
    Dio dio = Dio(options);
    try {
      Map data = {
        "transaction_reference": transactionReference,
        "otp": otp,
      };
      print(data);
      Response response = await dio.post(uri, data: data);

      print(response.data);

      if (response == null) return ErrorType.generic;
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

  //get list of billable items
  static Future<List<Payment>> getAllPaymentsByUser({
    @required String authToken,
    @required int userId,
  }) async {
    String uri = Endpoint.userPayment(userId: userId);

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      final items = mapResponse["payment"].cast<Map<String, dynamic>>();
      List<Payment> listOfPayments = items.map<Payment>((json) {
        return Payment.fromJson(json);
      }).toList();

      return listOfPayments;
    } else {
      return [];
    }
  }

  //get list of billable items
  static Future<Payment> getSinglePayment({
    @required String authToken,
    @required int paymentId,
  }) async {
    String uri = Endpoint.singlePayment(paymentId: paymentId);

    Options options = Options(
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Response response = await dio.get(uri, options: options);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.data);
      return Payment.fromJson(mapResponse);
    } else {
      return null;
    }
  }
}
