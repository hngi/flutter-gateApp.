import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/welcomepage1.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepageone()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("images/gatepass.png"),
                          Image.asset("images/logopass.png"),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 10.0),
                          ),
                          Text(
                            "Manage your quests peacefully",
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}