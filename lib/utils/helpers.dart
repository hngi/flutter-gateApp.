import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class GateMapHelpers {
  GateMapHelpers._(); //this helps to instantiate the class

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
