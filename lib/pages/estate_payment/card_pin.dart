import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/service/payment_service.dart';
import 'package:xgateapp/pages/estate_payment/otp.dart';
import 'package:xgateapp/utils/FlushAlert/flush_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';

class CardPin extends StatefulWidget {
  final String cardNo;
  final String cvv;
  final String expiryYear;
  final String expiryMonth;
  final int amount;
  final String email;
  final String country;
  final String currency;

  const CardPin({
    Key key,
    @required this.cardNo,
    @required this.cvv,
    @required this.expiryYear,
    @required this.expiryMonth,
    @required this.amount,
    @required this.email,
    @required this.country,
    @required this.currency,
  }) : super(key: key);

  _CardPinState createState() => _CardPinState();
}

class _CardPinState extends State<CardPin> {
  String _cardPin;
  GlobalKey<FormState> _cardPinFormKey = GlobalKey<FormState>();

  _onCardPinSubmit() async {
    var form = _cardPinFormKey.currentState;
    if (form.validate()) {
      form.save();

      LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
      dialog.show();

      var res = await PaymentService.insertCardPin(
        pin: _cardPin,
        authToken: await authToken(context),
        amount: widget.amount,
        // billId: widget.billId,
        cardNo: widget.cardNo.replaceAll(' ', ''),
        country: widget.country,
        currency: widget.currency,
        cvv: widget.cvv,
        email: getProfileProvider(context).profileModel.email,
        expirymonth: widget.expiryMonth,
        expiryyear: widget.expiryYear,
      );

      dialog.hide();

      var flRes = res['report']['res']['data'];

      if (res['report']['status'] != 200) {
        FlushAlert.show(
          context: context,
          message: 'Incorrect PIN / Merchnat error',
          isError: true,
        );
      } else if (res is ErrorType) {
        FlushAlert.show(
          context: context,
          message: GateManHelpers.errorTypeMap(res),
          isError: true,
        );
      } else if (flRes['flwRef'] == '' || flRes['flwRef'] == null) {
        FlushAlert.show(
          context: context,
          message: 'Invalid Transacion Reference',
          isError: true,
        );
      } else {
        var message = flRes['chargeResponseMessage'];
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new OTP(
            message: message,
            transactionRef: res['data']['flwRef '],
          );
        }));
      }
    }
  }

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
              'Please enter your Card PIN to continue with your transaction',
              style: TextStyle(
                color: GateManColors.grayColor,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            onSaved: (str) {
              _cardPin = str;
            },
            validator: (str) {
              return str.isEmpty ? 'Please enter Card PIN' : null;
            },
            obscureText: true,
            style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 16.0,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Card PIN',
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
            onPressed: _onCardPinSubmit,
          ),
        ],
      ),
    );
  }
}
