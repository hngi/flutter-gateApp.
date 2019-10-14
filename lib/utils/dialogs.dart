import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class GateManDialogs {
  GateManDialogs._();

  static Future successAlert({
    @required BuildContext context,
    @required String title,
    @required bool navToNewScreen,
    bool autoDissmiss,
    bool barrierDissmissible = false,
    Widget navTo,
  }) async {
    Size size = MediaQuery.of(context).size;
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: WillPopScope(
        onWillPop: () {
          if (navToNewScreen == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute<Null>(builder: (BuildContext context) {
              return navTo;
            }));
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Stack(children: [
          Container(
            height: size.height * .4,
            width: size.width * .80,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Icon(Icons.check_circle_outline,
                        size: 100.0, color: GateManColors.primaryColor),
                  ),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: GateManColors.grayColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.0)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 3.0,
            child: IconButton(
              icon: Icon(Icons.cancel, color: GateManColors.primaryColor),
              onPressed: () {
                if (navToNewScreen == true) {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return navTo;
                  }));
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ]),
      ),
    );

    return showDialog(
      context: context,
      barrierDismissible: barrierDissmissible,
      builder: (context) => dialog,
    );
  }

  //For Error alrt
  static Future errorAlert({
    @required BuildContext context,
    @required String title,
    @required String subtitle,
    @required bool navToNewScreen,
    bool autoDissmiss,
    Widget navTo,
  }) async {
    Size size = MediaQuery.of(context).size;
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: WillPopScope(
        onWillPop: () {
          if (navToNewScreen) {
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return navTo;
            }));
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Stack(children: [
          Container(
            height: 200.0,
            width: size.width * .65,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.cancel, color: Colors.red, size: 40.0),
                  ),
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 25.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 3.0,
            child: IconButton(
              icon: Icon(Icons.cancel, color: GateManColors.primaryColor),
              onPressed: () {
                if (navToNewScreen) {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return navTo;
                  }));
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ]),
      ),
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => dialog,
    );
  }
}
