class Endpoint {
  //Base URL
  static String baseUrl = 'https://gateappapi.herokuapp.com/api/v1/';// http://52.200.161.52/api/v1/';

  //Auth
  static String login = '/login';
  static String adminRegister = '/register/admin';
  static String gatemanRegister = '/register/gateman';
  static String residentRegister = '/register/resident';
  static String verifyAccount = '/verify';
  static String passwordVerify = '/password/verify';
  static String passwordReset = '/password/reset';
  static String estate = '/estate';
  static String getEstateByCity = '/estate/city';
  static String getEstateByCountry = '/estate/country';
  static String estates = '/estates';
  static String deleteEstate = '/estate/delete';
  static String visitor = '/visitor';
}
