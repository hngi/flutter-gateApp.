import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';

class OTP extends StatefulWidget {
  final String transactionRef;
  final String message;

  const OTP({Key key, @required this.transactionRef, @required this.message})
      : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
        children: <Widget>[
          SizedBox(height: 12.0),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 13.0),
            child: Text(
              widget.message ??
                  'Enter OTP sent to your number associated with your account',
              style: TextStyle(
                color: GateManColors.grayColor,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            onSaved: (str) {},
            validator: (str) {},
            obscureText: true,
            style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 16.0,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'OTP',
              prefixIcon: Icon(MdiIcons.lock, size: 13),
              contentPadding: EdgeInsets.all(10.0),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GateManColors.grayColor,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              enabledBorder: GateManHelpers.textFieldBorder,
              border: GateManHelpers.textFieldBorder,
            ),
          ),
          SizedBox(height: 13.0),
          ActionButton(
            buttonText: 'Pay',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
