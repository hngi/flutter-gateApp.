// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/pages/Pager/pager.dart';
import 'package:gateapp/pages/add_gateman.dart';
import 'package:gateapp/pages/add_visitor.dart';
import 'package:gateapp/pages/gateman/qrScan.dart';
import 'package:gateapp/pages/gateman/welcome.dart';
import 'package:gateapp/pages/notification_resident.dart';
import 'package:gateapp/pages/registration/token_confirmation.dart';
import 'package:gateapp/pages/resident/add_gateman/add_gateman_detail.dart';
import 'package:gateapp/pages/visitor_profile.dart';
import 'package:gateapp/pages/edit_info.dart';
import 'package:gateapp/pages/edit_profile.dart';
import 'package:gateapp/pages/gateman/notifications.dart';
import 'package:gateapp/pages/gateman_menu.dart';
import 'package:gateapp/pages/homepage.dart';
import 'package:gateapp/pages/incoming_visitors.dart';
import 'package:gateapp/pages/incoming_visitors_list.dart';
import 'package:gateapp/pages/manage_gateman.dart';
import 'package:gateapp/pages/register.dart';
import 'package:gateapp/pages/residents.dart';
import 'package:gateapp/pages/scan_qr_code.dart';
import 'package:gateapp/pages/section_seven/add_visitor.dart';
//import 'package:gateapp/pages/manage_address.dart';
import 'package:gateapp/pages/service_directory/service_directory_resident_detail.dart';
import 'package:gateapp/pages/service_directory/service_directory_resident.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/pages/about.dart';
import 'package:gateapp/pages/faq.dart';
import 'package:gateapp/pages/manage_address.dart';
import 'package:gateapp/pages/privacypolicy.dart';
import 'package:gateapp/pages/settings.dart';
import 'package:gateapp/pages/splash_screen.dart';
import 'package:gateapp/pages/welcome_resident.dart';
import 'package:gateapp/pages/welcomepage1.dart';
import 'package:gateapp/pages/add_permission.dart';
import 'package:gateapp/pages/user_type.dart';
import 'package:gateapp/pages/gateman/register.dart';

import '../pages/gateman/menu.dart';
import '../pages/gateman/residents.dart';
import '../pages/gateman/scheduledVisit.dart';
import '../pages/gateman/visitors.dart';

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

      case '/about':
        return MaterialPageRoute(builder: (context) => About());

      case '/privacy-policy':
        return MaterialPageRoute(builder: (context) => PrivacyPolicy());

      case '/faq':
        return MaterialPageRoute(builder: (context) => FAQ());

      case '/manage-address':
        return MaterialPageRoute(builder: (context) => ManageAddress());

      case '/add-location':
        return MaterialPageRoute(builder: (context) => AddLocationPermission());

      case '/user-type':
        return MaterialPageRoute(builder: (context) => UserType());

      case '/add-estate':
        return MaterialPageRoute(builder: (context) => AddEstate());

      case '/select-estate':
        return MaterialPageRoute(builder: (context) => SelectAddress());

      case '/service_directory_resident':
        return MaterialPageRoute(
            builder: (context) => ServiceDirectoryResident());

      case '/service_directory_resident_detail':
        return MaterialPageRoute(
            builder: (context) => ServiceDirectoryResidentDetail(
                  category: settings.arguments,
                ));

      case '/add_visitor':
        return MaterialPageRoute(builder: (context) => AddVisitor());

      case '/visitor-profile':
        return MaterialPageRoute(builder: (context) => VisitorProfile());

      case '/add-gateman':
        return MaterialPageRoute(builder: (context) => AddGateman());

      case '/add-a-visitor':
        return MaterialPageRoute(builder: (context) => AddAVisitor());

      case '/edit-info':
        return MaterialPageRoute(builder: (context) => EditInfo());

      case '/edit-profile':
        return MaterialPageRoute(builder: (context) => EditProfile());

      case '/homepage':
        return MaterialPageRoute(builder: (context) => Homepage());

      case '/incoming-visitors':
        return MaterialPageRoute(builder: (context) => IncomingVisitors());

      case '/incoming-visitors-list':
        return MaterialPageRoute(builder: (context) => IncomingVisitorsList());

      case '/manage-address':
        return MaterialPageRoute(builder: (context) => ManageAddress());

      case '/manage-gateman':
        return MaterialPageRoute(builder: (context) => ManageGateman());

      case '/register':
        return MaterialPageRoute(builder: (context) => Register());

      case '/residents':
        return MaterialPageRoute(builder: (context) => Residents());

      case '/token-conirmation':
        dynamic info = settings.arguments;
        return MaterialPageRoute(
            builder: (context) =>
                TokenConfirmation(phone: info['phone'], email: info['email']));

      case '/welcome-resident':
        return MaterialPageRoute(builder: (context) => WelcomeResident());

      case '/gateman-register':
        return MaterialPageRoute(builder: (context) => GatemanRegister());

      case '/resident-settings':
        return MaterialPageRoute(builder: (context) => Settings());

      case '/gateman-menu':
        return MaterialPageRoute(builder: (context) => GatemanWelcome());

      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());

      case '/scan-qr':
        return MaterialPageRoute(builder: (context) => ScanQRCode());

      case '/gateman-notifications':
        return MaterialPageRoute(builder: (context) => GatemanNotifications());

      case '/resident-notifications':
        return MaterialPageRoute(builder: (context) => NotificationResident());

      case '/residents-gate':
        return MaterialPageRoute(builder: (context) => ResidentsGate());

      case '/menu':
        return MaterialPageRoute(builder: (context) => Menu());

      case '/scheduled-visit':
        return MaterialPageRoute(builder: (context) => ScheduledVisit());

      case '/visitors-list':
        return MaterialPageRoute(builder: (context) => VisitorsList());

      case '/qrReader':
        return MaterialPageRoute(builder: (context) => ScanQRCode2());

      case '/add-gateman-detail':
        return MaterialPageRoute(builder: (context) => AddGateManDetail());

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
