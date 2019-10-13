import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class SmallButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double horizontalPadding;
  final double verticalPadding;


  SmallButton({
    @required this.buttonText,
    @required this.onPressed,
    this.horizontalPadding,
    this.verticalPadding = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding??6),
      child: RaisedButton(
        color: GateManColors.primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Container(
          height: 14.0,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
