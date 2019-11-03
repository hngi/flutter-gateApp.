// import 'pages/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/screen_models.dart';
import 'package:xgateapp/pages/Add_Estate.dart';
import 'package:xgateapp/pages/Pager/pager.dart';
import 'package:xgateapp/pages/add_gateman.dart';
import 'package:xgateapp/pages/add_visitor.dart';
import 'package:xgateapp/pages/gateman/qrScan.dart';
import 'package:xgateapp/pages/notification_resident.dart';
import 'package:xgateapp/pages/registration/token_confirmation.dart';
import 'package:xgateapp/pages/resident/add_gateman/add_gateman_detail.dart';
import 'package:xgateapp/pages/support.dart';
import 'package:xgateapp/pages/visitor_profile.dart';
import 'package:xgateapp/pages/edit_info.dart';
import 'package:xgateapp/pages/edit_profile.dart';
import 'package:xgateapp/pages/gateman/notifications.dart';
import 'package:xgateapp/pages/gateman_menu.dart';
import 'package:xgateapp/pages/homepage.dart';
import 'package:xgateapp/pages/incoming_visitors.dart';
import 'package:xgateapp/pages/incoming_visitors_list.dart';
import 'package:xgateapp/pages/manage_gateman.dart';
import 'package:xgateapp/pages/register.dart';
import 'package:xgateapp/pages/residents.dart';
import 'package:xgateapp/pages/scan_qr_code.dart';
import 'package:xgateapp/pages/section_seven/add_visitor.dart';
//import 'package:xgateapp/pages/manage_address.dart';
import 'package:xgateapp/pages/service_directory/service_directory_resident_detail.dart';
import 'package:xgateapp/pages/service_directory/service_directory_resident.dart';
import 'package:xgateapp/pages/Select_Estate.dart';
import 'package:xgateapp/pages/about.dart';
import 'package:xgateapp/pages/faq.dart';
import 'package:xgateapp/pages/manage_address.dart';
import 'package:xgateapp/pages/privacypolicy.dart';
import 'package:xgateapp/pages/settings.dart';
import 'package:xgateapp/pages/splash_screen.dart';
import 'package:xgateapp/pages/visitors.dart';
import 'package:xgateapp/pages/welcome_resident.dart';
import 'package:xgateapp/pages/add_permission.dart';
import 'package:xgateapp/pages/user_type.dart';
import 'package:xgateapp/pages/gateman/register.dart';

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

      // case '/manage-address':
      //   return MaterialPageRoute(builder: (context) => ManageAddress());

      case '/about':
        return MaterialPageRoute(builder: (context) => About());

      case '/privacy-policy':
        return MaterialPageRoute(builder: (context) => PrivacyPolicy());

      case '/faq':
        return MaterialPageRoute(builder: (context) => FAQ());

      // case '/manage-address':
      //   return MaterialPageRoute(builder: (context) => ManageAddress());

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
        AddEditVisitorScreenModel screenModel= settings.arguments;
        return MaterialPageRoute(builder: (context) => AddVisitor(
          description: screenModel?.description,
          visitorId: screenModel?.visitorId,
          editMode: screenModel?.editMode,
          initName: screenModel?.initName,
          initArrivalDate: screenModel?.initArrivalDate,
          initArrivalPeriod: screenModel?.initArrivalPeriod,
          initCarPlateNumber: screenModel?.initCarPlateNumber,
          initPurpose: screenModel?.initPurpose,
          initVisitorsImageLink: screenModel?.initVisitorsImageLink,
          initVisitorsPhoneNo: screenModel?.initVisitorsPhoneNo,
        ));

      case '/visitor-profile':
        return MaterialPageRoute(builder: (context) => VisitorProfile(model: settings.arguments,));

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
      print('printing manage address arguments');
      print(settings.arguments);
        return MaterialPageRoute(builder: (context) => ManageAddress(houseBlock: settings.arguments,));

      case '/manage-gateman':
        return MaterialPageRoute(builder: (context) => ManageGateman());

      case '/register':
        return MaterialPageRoute(builder: (context) => Register());

      case '/support':
        return MaterialPageRoute(builder: (context) => SupportPage());

      case '/residents':
        return MaterialPageRoute(builder: (context) => Residents());

      case '/token-conirmation':
        dynamic info = settings.arguments;
        return MaterialPageRoute(
            builder: (context) =>
                TokenConfirmation(phone: info['phone'], /*email: info['email']*/
                skipSelectEstate:info['skip_estate']));

      case '/welcome-resident':
        return MaterialPageRoute(builder: (context) => WelcomeResident());

      case '/gateman-register':
        return MaterialPageRoute(builder: (context) => GatemanRegister());

      case '/resident-settings':
        return MaterialPageRoute(builder: (context) => Settings());

      case '/gateman-menu':
        return MaterialPageRoute(builder: (context) => GateManMenu());

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
      
      case '/my-visitors':
        return MaterialPageRoute(builder: (context) => MyVisitors());

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
