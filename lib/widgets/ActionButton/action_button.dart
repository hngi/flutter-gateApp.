import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;

  ActionButton({
    @required this.buttonText,
    @required this.onPressed,
    this.color,
    this.horizontalPadding = 15.0,
    this.verticalPadding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: RaisedButton(
        color: color ?? GateManColors.primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          height: 55.0,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
