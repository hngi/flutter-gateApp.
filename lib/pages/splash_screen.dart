import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white, //top bar color
    // ));

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/add-location');
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
