import 'package:flutter/material.dart';

class GateManColors {
  GateManColors._(); //this helps to instantiate the class

  static MaterialColor primarySwatchColor = MaterialColor(0xFF49A347, colorMap);

  static Map<int, Color> colorMap = {
    50: Color.fromRGBO(73, 163, 71, .1),
    100: Color.fromRGBO(73, 163, 71, .2),
    200: Color.fromRGBO(73, 163, 71, .3),
    300: Color.fromRGBO(73, 163, 71, .4),
    400: Color.fromRGBO(73, 163, 71, .5),
    500: Color.fromRGBO(73, 163, 71, .6),
    600: Color.fromRGBO(73, 163, 71, .7),
    700: Color.fromRGBO(73, 163, 71, .8),
    800: Color.fromRGBO(73, 163, 71, .9),
    900: Color.fromRGBO(73, 163, 71, 1),
  };

  static Color primaryColor = Color(0xFF49A347);
  static Color textColor = Color(0xFF4F4F4F);
  static Color grayColor = Color(0xFF464646);
  static Color blackColor = Color(0xFF4F4F44);
}
