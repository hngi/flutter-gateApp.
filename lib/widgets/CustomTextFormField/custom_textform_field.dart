import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelName;
  final String initialValue;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final String Function(String) validator;
  final bool isPassword;
  final int maxLines;

  const CustomTextFormField({
    Key key,
    @required this.labelName,
    this.initialValue,
    this.icon,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.keyboardType = TextInputType.text,
    @required this.onSaved,
    this.onChanged,
    @required this.validator,
    this.isPassword = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
            child: Text(widget.labelName,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
          ),
          TextFormField(
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            controller: widget.controller,
            validator: widget.validator,
            initialValue: null,
            obscureText: widget.isPassword ? true : false,
            style: TextStyle(
              color: GateManColors.textColor,
            ),
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon ?? null,
              suffixIcon: widget.suffixIcon ?? null,
              // suffix: suffix ?? SizedBox(),
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
