import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class GateManHelpers {
  GateManHelpers._(); //this helps to instantiate the class

  //List<String> _menuList = ['About', 'South Africa', 'China'];

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
          icon: Icon(Icons.more_vert),
          onPressed: () {},
          color: Colors.white,
        ),
      ],
    );
  }

  //borders around the text fields
  static final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide(
      color: GateManColors.primaryColor,
      style: BorderStyle.solid,
      width: 1.0,
    ),
  );
}

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(0.0),
      height: 15.0,
      width: 15.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}