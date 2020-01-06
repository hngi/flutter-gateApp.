import 'package:flutter/material.dart';
import 'package:xgateapp/pages/estate_payment/widgets/payment_method_item.dart';
import 'package:xgateapp/utils/colors.dart';

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lock, color: Color(0XFF808080)),
                SizedBox(width: 10.0),
                Text('SECURED BY FLUTTERWAVE',
                    style: TextStyle(
                        color: Color(0XFF808080),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text('How would you\n like to pay?',
                style: TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(
            height: 3.0,
            color: GateManColors.primaryColor,
            thickness: 3.0,
            endIndent: size.width * 0.55,
          ),
          Spacer(),
          PaymentMethodItem(
            method: 'Card',
            isActive: false,
          ),
          PaymentMethodItem(
            method: 'Account',
            isActive: false,
          ),
          PaymentMethodItem(
            method: 'Bank Transfer',
            isActive: false,
          ),
          PaymentMethodItem(
            method: 'USSD',
            isActive: false,
          ),
        ],
      ),
    );
  }
}
