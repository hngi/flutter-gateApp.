import 'package:flutter/material.dart';
import 'package:xgateapp/utils/helpers.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final Function(String) onSaved;
  final String Function(String) validator;
  final Widget prefix;
  final TextEditingController textEditingController;
  final int maxLines;
  final bool enabled;

  final bool forCustomDatePicker;

  const CustomInputField({
    Key key,
    @required this.hint,
    @required this.keyboardType,
    this.onSaved,
    this.validator,
    @required this.prefix,
    this.maxLines = 1,
    this.textEditingController,
    this.enabled = true,
    this.forCustomDatePicker=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: TextFormField(
          maxLines: maxLines,
          onSaved: onSaved,
          validator: validator,
          style: TextStyle(
            color: GateManColors.textColor,
          ),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12,color: Color(0x663333)),
            prefixIcon: prefix,
            contentPadding: EdgeInsets.only(left: 6.0, top: 13, bottom: 13),
            focusedBorder: GateManHelpers.textFieldBorder,
            enabledBorder: GateManHelpers.textFieldBorder,
            border:GateManHelpers.textFieldBorder,
          ),
        ));*/

   return TextField(
      enabled: this.enabled,
      controller: this.textEditingController,
      decoration: InputDecoration(
        disabledBorder: forCustomDatePicker?GateManHelpers.textFieldBorder:null,
        border: GateManHelpers.textFieldBorder,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12,color: Color(0xFF4F4F4F)),
        prefixIcon: prefix,
        contentPadding: EdgeInsets.only(left: 6.0, top: 13, bottom: 13),
      ),
    );
  }
}
