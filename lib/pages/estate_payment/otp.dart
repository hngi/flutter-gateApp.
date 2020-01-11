import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/service/payment_service.dart';
import 'package:xgateapp/pages/estate_payment/estate_payments.dart';
import 'package:xgateapp/utils/FlushAlert/flush_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
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
  GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  String _otp;

  _onOtpSubmit() async {
    var form = _otpFormKey.currentState;
    if (form.validate()) {
      form.save();

      LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
      dialog.show();

      var res = await PaymentService.otpConfirmation(
        authToken: await authToken(context),
        otp: _otp,
        transactionReference: widget.transactionRef,
      );

      dialog.hide();

      var flRes = res['report']['res']['data'];

      if (res['report']['status'] != 200) {
        FlushAlert.show(
          context: context,
          message: 'Transaction incomplete',
          isError: true,
        );
      } else if (res is ErrorType) {
        FlushAlert.show(
          context: context,
          message: GateManHelpers.errorTypeMap(res),
          isError: true,
        );
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new EstatePayments();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _otpFormKey,
        child: ListView(
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
              onSaved: (str) {
                _otp = str;
              },
              validator: (str) {
                return str.isEmpty ? 'Please enter OTP' : null;
              },
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
              onPressed: _onOtpSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
