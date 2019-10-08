import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelName;
  final String initialValue;
  final TextInputType keyboardType;
  final Function(String) onSaved;
  final String Function(String) validator;
  final Widget suffix;
  final bool isPassword;
  final int maxLines;

  const CustomTextFormField({
    Key key,
    @required this.labelName,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    @required this.onSaved,
    @required this.validator,
    this.suffix,
    this.isPassword = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text(labelName,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
          ),
          TextFormField(
            maxLines: maxLines,
            onSaved: onSaved,
            
            validator: validator,
            initialValue: initialValue ?? '',
            obscureText: isPassword ? true : false,
            style: TextStyle(
              color: GateManColors.textColor,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: '',
              suffix: suffix ?? SizedBox(),
              contentPadding: EdgeInsets.all(10.0),
              focusedBorder: GateManHelpers.textFieldBorder,
              enabledBorder: GateManHelpers.textFieldBorder,
              border: GateManHelpers.textFieldBorder,
              // labelText: labelName,
              // labelStyle: TextStyle(color: GateManColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
