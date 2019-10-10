// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/pages/Pager/pager.dart';
//import 'package:gateapp/pages/manage_address.dart';
import 'package:gateapp/pages/service_directory/service_directory_resident_detail.dart';
import 'package:gateapp/pages/service_directory/service_directory_resident.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/pages/splash_screen.dart';
import 'package:gateapp/pages/add_permission.dart';
import 'package:gateapp/pages/user_type.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/pager':
        return MaterialPageRoute(builder: (context) => Pager());

      case '/add-location':
        return MaterialPageRoute(builder: (context) => AddLocationPermission(typeUser: settings.arguments));

      case '/user-type':
        return MaterialPageRoute(builder: (context) => UserType());

      case '/add-estate':
        return MaterialPageRoute(builder: (context) => AddEstate());

      case '/select-estate':
              return MaterialPageRoute(builder: (context) => ManageAddress());

      case '/service_directory_resident':
        return MaterialPageRoute(builder: (context) => ServiceDirectoryResident());
      
      case '/service_directory_resident_detail':
        return MaterialPageRoute(builder: (context) => ServiceDirectoryResidentDetail(detailData: settings.arguments,));

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                'There is nothing here check somewhere else',
              ),
            ),
          ),
        );
    }
  }
}
