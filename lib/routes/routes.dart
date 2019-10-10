// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/pages/Pager/pager.dart';
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
        return MaterialPageRoute(builder: (context) => AddPermission());

      case '/user-type':
        return MaterialPageRoute(builder: (context) => UserType());

      case '/add-estate':
        return MaterialPageRoute(builder: (context) => AddEstate());

      case '/select-estate':
              return MaterialPageRoute(builder: (context) => SelectAddress());

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
