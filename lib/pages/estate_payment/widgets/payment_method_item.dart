import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';

class PaymentMethodItem extends StatefulWidget {
  final String method;
  final bool isActive;

  const PaymentMethodItem({
    Key key,
    @required this.method,
    @required this.isActive,
  }) : super(key: key);
  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: GateManColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 22.0,
        vertical: 17.0,
      ),
      margin: EdgeInsets.only(bottom: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Pay with ' + widget.method,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            widget.isActive
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
