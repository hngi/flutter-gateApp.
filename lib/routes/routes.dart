// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/Pager/pager.dart';
import 'package:gateapp/pages/edit_profile.dart';
import 'package:gateapp/pages/manage_address.dart';
import 'package:gateapp/pages/register.dart';
import 'package:gateapp/pages/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/pager':
        return MaterialPageRoute(builder: (context) => Pager());

      case '/manage-address':
        return MaterialPageRoute(builder: (context) => ManageAddress());

      case '/edit-profile':
        return MaterialPageRoute(builder: (context) => EditProfile());

      case '/register':
        return MaterialPageRoute(builder: (context) => Register());

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
