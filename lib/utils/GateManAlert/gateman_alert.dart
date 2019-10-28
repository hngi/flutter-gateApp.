import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaysmosmoAlert {
  //Transition Duration
  static int _transDuration = 3;

  //Alerts for Errors
  static showError({
    @required BuildContext context,
    @required String message,
    bool isTop = true,
  }) async {
    await Flushbar(
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: Duration(seconds: _transDuration),
      icon: Icon(Icons.error),
      message: message,
      backgroundColor: Colors.red,
      title: 'ERROR',
    ).show(context);
  }

  //Alerts for Errors
  static showWarning({
    @required BuildContext context,
    @required String message,
    bool isTop = true,
  }) {
    Flushbar(
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: Duration(seconds: _transDuration),
      icon: Icon(Icons.error),
      message: message,
      backgroundColor: Colors.amber,
      title: 'WARNING',
    ).show(context);
  }

//Alerts for Info
  static showInfo({
    @required BuildContext context,
    @required String message,
    bool isTop = true,
  }) {
    Flushbar(
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: Duration(seconds: _transDuration),
      icon: Icon(Icons.info),
      message: message,
      backgroundColor: Colors.blue,
      title: 'INFO',
    ).show(context);
  }

//Alerts for Success
  static showSuccess({
    @required BuildContext context,
    @required String message,
    bool isTop = true,
  }) async {
    await Flushbar(
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: Duration(seconds: _transDuration),
      icon: Icon(MdiIcons.handOkay),
      message: message,
      backgroundColor: GateManColors.primaryColor,
      title: 'SUCCESS',
    ).show(context);
  }
}
