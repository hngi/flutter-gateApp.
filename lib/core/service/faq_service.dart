
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/constants.dart' as prefix1;
import 'package:gateapp/utils/errors.dart';


class FAQService {

  static BaseOptions option = BaseOptions(
    baseUrl: Endpoint.baseUrl,
    responseType: ResponseType.plain,
    connectTimeout: prefix1.CONNECT_TIMEOUT,
    receiveTimeout: prefix1.RECEIVE_TIMEOUT,
    validateStatus: (code) {
      return (code >= 200) ? true : false;
    },
  );

  static getFAQ() async{
    var uri = Endpoint.getFAQ;

    try {
      Dio dio = Dio(option);
      Response response = await dio.get(uri);

      print(response.statusCode);
      print(response.data);

      if ((response.statusCode == 404)) {
        return ErrorType.no_visitors_found;
      } else if ((response.statusCode == 401)) {
        return ErrorType.account_not_confimrmed;
      } else if (response.statusCode == 200){
        return json.decode(response.data);
      }
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