import 'package:flutter/material.dart';

class Endpoint {
  //Image Base Url
  static String imageBaseUrl =
      'https://res.cloudinary.com/getfiledata/image/upload/w_200,c_fill,ar_1:1,g_auto,r_max/';
  //Base URL
  static String baseUrl = 'https://gateappapi.herokuapp.com/api/v1';
  //'https://b51df2ea.ngrok.io/api/v1'

  //Auth
  static String login = '/login';
  static String adminRegister = '/register/admin';
  static String gatemanRegister = '/register/gateman';
  static String residentRegister = '/register/resident';
  static String verifyAccount = '/verify';
  static String passwordVerify = '/password/verify';
  static String passwordReset = '/password/reset';

  //Service Categories
  static String serviceProvider = '/service-provider';
  static String serviceProviderCategory = '/sp-category';
  //Esate
  //static String estate = '/estate';
  static String resendOTPtoken = '/resend/token';
  static String getCurrentUser = '/user';
  static String editCurrentuser = '/user/edit';
  static String deleteCurrentUser = '/user/delete';
  static String estate = '/estate';
  static String getEstateByCity = '/estate/city';
  static String getEstateByCountry = '/estate/country';
  static String estates = '/estates';
  static String deleteEstate = '/estate/delete';
  static String visitor = '/visitor';
  static String showVisitors = 'gateman/visitors';
  static String showRequests = '/gateman/requests';
  static String gatemanRequests = '/gateman/requests';
  static String gateman = '/gateman';

  //Service Categories
  // static String serviceProvider = '/service-provider';
  // static String serviceProviderCategory = '/sp-category';

  static String addGateMan({@required int gatemanId}) =>
      '/resident/addGateman/$gatemanId';
  static String searchGatemanByPhone({@required String gatemanPhone}) =>
      '/search/gateman/phone/$gatemanPhone';
  static String searchGatemanByName({@required String gatemanName}) =>
      '/search/gateman/name/$gatemanName';
  static String viewGatemanThatAccepted = '/resident/acceptedInvitation';
  static String viewGatemanYetToAccept = 'resident/pendingInvitation';
  static String deleteGateman({@required int gatemanId}) =>
      'resident/removeGateman/$gatemanId';
}
