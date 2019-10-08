import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Function(T) onChanged;
  final String label;
  final String hintText;
  final Widget prefixIcon;

  const CustomDropdownButton({
    Key key,
    @required this.items,
    @required this.value,
    @required this.onChanged,
    @required this.label,
    @required this.hintText,
    this.prefixIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text(label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
          ),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(18.0),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 14.0),
              hintText: hintText,
              prefixIcon: prefixIcon ?? null,
              focusedBorder: GateManHelpers.textFieldBorder,
              enabledBorder: GateManHelpers.textFieldBorder,
              border: GateManHelpers.textFieldBorder,
            ),
            // isEmpty: _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                iconEnabledColor: GateManColors.primaryColor,
                style: TextStyle(color: GateManColors.textColor),
                value: value,
                isDense: true,
                onChanged: onChanged,
                items: items,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
