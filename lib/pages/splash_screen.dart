import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gateapp/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  Map<user_type,String> mapUserTypeToPage = {
    user_type.RESIDENT:'/welcome-resident',
    user_type.GATEMAN:'/gateman_menu',
  };
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white, //top bar color
    // ));

    Future.delayed(Duration(seconds: 5), () async{
      if (await authToken(context)==null || await userType(context)==null){
        Navigator.pushReplacementNamed(context, '/pager');
      } else {
        print(await authToken(context));
        user_type routeString = await userType(context);
        await loadInitialProfile(context);
        if (routeString == user_type.RESIDENT){
          await loadGateManThatAccepted(context);
         await loadInitialVisitors(context);
        }
        Navigator.pushReplacementNamed(context, mapUserTypeToPage[routeString]);
      }
      
      
    });

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