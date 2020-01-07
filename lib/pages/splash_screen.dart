import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:xgateapp/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<user_type, String> mapUserTypeToPage = {
    user_type.RESIDENT: '/resident-main-page',
    user_type.GATEMAN: '/gateman-menu',
  };

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() {
    Future.delayed(Duration(seconds: 1), () async {
      if (await authToken(context) == null || await userType(context) == null) {
        getUserTypeProvider(context).setFirstRunStatus(true);
        Navigator.pushReplacementNamed(context, '/pager');
        
      } else {
        print(await authToken(context));
        // Navigator.pushReplacementNamed(
        //     context, mapUserTypeToPage[await userType(context)]);
        user_type routeString = await userType(context);
        getProfileProvider(context).setProfileModelFromPrefs();
        if (routeString == user_type.RESIDENT) {
         getVisitorProvider(context).setVisitorModelsFromPrefs();
         getResidentsGateManProvider(context)
                                      ..setResidentsGateManAwaitingModelsFromPrefs()
                                      ..setResidentsGateManModelsFromPrefs();
          getVisitorProvider(context)
                              ..setScheduledVisitorFromPrefs()
                              ..setSavedVisitorFromPrefs()
                              ..setHistoryVisitorFromPrefs();
                              

        }
        getUserTypeProvider(context).setFirstRunStatus(false);
        Navigator.pushReplacementNamed(context, mapUserTypeToPage[routeString]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640, allowFontScaling: true)..init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 10.0),
                Image.asset('assets/images/gate_pass.png'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Manage your Guests peacefully',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ]),
        ),
      ),
    );
  }
}
