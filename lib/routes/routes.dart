// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/pages/Pager/pager.dart';
import 'package:gateapp/pages/Select_Estate.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => ManageAddress());

     
      case '/pager':
        return MaterialPageRoute(builder: (context) => Pager());

      case '/manage-address':
        return MaterialPageRoute(builder: (context) => ManageAddress());
         case '/add-estate':
        return MaterialPageRoute(builder: (context) => AddEstate());

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
