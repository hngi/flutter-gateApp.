import 'package:flutter/material.dart';

class Homepageone extends StatefulWidget {
  @override
  _HomepageoneState createState() => _HomepageoneState();
}

class _HomepageoneState extends State<Homepageone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text("data"),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text("data"),
          )
        ],
      ),
    );
  }
}