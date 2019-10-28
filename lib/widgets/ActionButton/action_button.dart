import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final bool hasColor;

  ActionButton({
    @required this.buttonText,
    @required this.onPressed,
    this.color,
    this.hasColor=false,
    this.horizontalPadding,
    this.verticalPadding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding??20),
      child: RaisedButton(
        color: hasColor ?color: GateManColors.primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
