import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class FlushAlert {
  //Transition Duration
  static int _transDuration = 3;
  static Flushbar flushBar;

  static show({
    @required BuildContext context,
    @required String message,
    bool isError = false,
    bool isTop = false,
    bool isDismisble = false,
    Function onPressed,
    Widget onPressedWidget,
    Duration duration,
  }) async {
    // assert(isDismisble != true && onPressed != null);
    // assert(onPressed != null && onPressedWidget != null);

    await Flushbar(
      duration: duration != null
          ? duration
          : Duration(seconds: isDismisble ? 10 : _transDuration),
      message: message,
      backgroundColor: !isError ? GateManColors.primaryColor : Colors.red,
      mainButton: isDismisble
          ? FlatButton(
              onPressed: () {
                flushBar.dismiss([]);
              },
              child: Icon(
                Icons.cancel,
                color: Colors.white,
                size: 20,
              ),
            )
          : onPressed != null
              ? FlatButton(
                  onPressed: onPressed,
                  child: onPressedWidget,
                )
              : FlatButton(
                  onPressed: null,
                  child: SizedBox(),
                ),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);

    // flushBar = Flushbar(
    //   duration: duration != null
    //       ? duration
    //       : Duration(seconds: isDismisble ? 10 : _transDuration),
    //   message: message,
    //   backgroundColor: !isError ? primaryColor : Colors.red,
    //   mainButton: isDismisble
    //       ? FlatButton(
    //           onPressed: () {
    //             flushBar.dismiss([]);
    //           },
    //           child: Icon(
    //             Icons.cancel,
    //             color: Colors.white,
    //             size: 20,
    //           ),
    //         )
    //       : onPressed != null
    //           ? FlatButton(
    //               onPressed: onPressed,
    //               child: onPressedWidget,
    //             )
    //           : FlatButton(
    //               onPressed: null,
    //               child: SizedBox(),
    //             ),
    //   flushbarStyle: FlushbarStyle.GROUNDED,
    // )..show(context);
  }
}
