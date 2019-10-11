import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class GateManHelpers {
  GateManHelpers._(); //this helps to instantiate the class

  // This is used to calculate the size of component based on the current height of the screen
  static double screenAwareSize(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.height;
  }

  static double screenAwareWidth(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.width;
  }

  //default app bar
  static AppBar appBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Navigator.pushReplacementNamed(context, '/setting'),
          color: Colors.white,
        ),
      ],
    );
  }

  //borders around the textfields
  static final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide(
      color: GateManColors.primaryColor,
      style: BorderStyle.solid,
      width: 1.0,
    ),
  );
}
