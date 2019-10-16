



import 'package:flutter/material.dart';
import 'package:gateapp/core/service/auth_service.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';

class TokenConfirmation extends StatefulWidget{
  @override
  _TokenConfirmationState createState() => _TokenConfirmationState();
}

class _TokenConfirmationState extends State<TokenConfirmation> {
  TextEditingController tokenController;

  @override
  void dispose() {
    // TODO: implement dispose
    tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Confirm OTP'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Enter OTP'),
          CustomInputField(hint: 'Enter OTP sent to your email', keyboardType: TextInputType.number, prefix: Icon(Icons.verified_user),
          textEditingController: tokenController,),
          FlatButton(child: Text('Veify'), onPressed: () {
            try{
              AuthService.verifyAccount(verificationCode: tokenController.text);
            } catch(error){
              print(error);
            }

          },)
        ],
      ),
    );
  }
}