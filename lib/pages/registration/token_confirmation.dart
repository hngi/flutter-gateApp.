import 'package:flutter/material.dart';
import 'package:gateapp/core/service/auth_service.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:provider/provider.dart';

class TokenConfirmation extends StatefulWidget {
  String phone;
  String email;
  String showAlertMessage;
  TokenConfirmation(
      {this.phone = '08056664098',
      this.email = 'winninggreat@gmail.com',
      this.showAlertMessage});
  @override
  _TokenConfirmationState createState() => _TokenConfirmationState();
}

class _TokenConfirmationState extends State<TokenConfirmation> {
  TextEditingController firstTokenController = TextEditingController(text: '');
  TextEditingController secondTokenController = TextEditingController(text: '');
  TextEditingController thirdTokenController = TextEditingController(text: '');
  TextEditingController fourthTokenController = TextEditingController(text: '');
//  TextEditingController fifthTokenController = TextEditingController(text: '');
//  TextEditingController sixthTokenController = TextEditingController(text: '');

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
//  FocusNode fifthFocusNode = FocusNode();
//  FocusNode sixthFocusNode = FocusNode();
  List<TextEditingController> get getControllers {return [
    firstTokenController,secondTokenController,thirdTokenController,
  fourthTokenController
//    fifthTokenController,sixthTokenController

  ];} 
  /*
  FocusNode firstFocusNode = FocusNode(canRequestFocus: true);
  FocusNode secondFocusNode = FocusNode(canRequestFocus: true);
  FocusNode thirdFocusNode = FocusNode(canRequestFocus: true);
  FocusNode fourthFocusNode = FocusNode(canRequestFocus: true);
  FocusNode fifthFocusNode = FocusNode(canRequestFocus: true);
  FocusNode sixthFocusNode = FocusNode(canRequestFocus: true);
  List<TextEditingController> get getControllers {
    return [
      firstTokenController,
      secondTokenController,
      thirdTokenController,
      fourthTokenController,
      fifthTokenController,
      sixthTokenController
    ];
  }*/

  List<FocusNode> get getFocusNodes {
    return [
      firstFocusNode,
      secondFocusNode,
      thirdFocusNode,
      fourthFocusNode
//      fifthFocusNode,
//      sixthFocusNode
    ];
  }

  // @override
  // void initState(){
  //   super.initState();
  //   getControllers.forEach((f)
  //   {

  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    getControllers.forEach((f) {
      f.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TokenProvider tokenProvider =
        Provider.of<TokenProvider>(context, listen: false);
    LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);

    // TODO: implement build
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Verify Account'),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Please enter the 6 digit verification code sent to ' +
                        this.widget.email,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 2.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: getControllers.map((controller) {
                            return Container(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: TextField(
                                    decoration: tokenBoxDecoration(),
                                    obscureText: true,
                                    focusNode: getFocusNodes[
                                        getControllers.indexOf(controller)],
                                    onChanged: (str) {
                                      if (str.length == 1) {
                                        if (getControllers.indexOf(controller) +
                                                1 <
                                            6) {
                                          FocusScope.of(context).requestFocus(
                                              getFocusNodes[getControllers
                                                      .indexOf(controller) +
                                                  1]);
                                        }
                                      } else if (str.length == 0) {
                                        if (getControllers.indexOf(controller) -
                                                1 >=
                                            0) {
                                          FocusScope.of(context).requestFocus(
                                              getFocusNodes[getControllers
                                                      .indexOf(controller) -
                                                  1]);
                                        }
                                      }
                                    },
                                    controller: controller,
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                          }).toList()),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FlatButton(
                    child: Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: GateManColors.primaryColor,
                    onPressed: () async {
                      String otpCode = firstTokenController.text +
                          secondTokenController.text +
                          thirdTokenController.text +
                          fourthTokenController.text ;
//                          fifthTokenController.text +
//                          sixthTokenController.text;
                      if (otpCode.length < 4) {
                        await PaysmosmoAlert.showError(
                            context: context,
                            message: 'Token must be 4 digits');
                      } else {
                        dialog.show();

                        try {
                          print(otpCode);
                          dynamic response = await AuthService.verifyAccount(
                              verificationCode: otpCode);
                          if (response is ErrorType) {
                            if (response ==
                                ErrorType.account_already_verified) {
                              //dynamic loginResponse = await AuthService.loginUser(phone: null);
                              dialog.hide();
                            } else {
                              await PaysmosmoAlert.showError(
                                  context: context,
                                  message:
                                      GateManHelpers.errorTypeMap(response));
                              dialog.hide();
                            }
                          } else {
                            if (response['token'].length > 0) {
                              print(response['token']);
                              tokenProvider.setToken(
                                  response['token'].toString().split(' ')[1]);
                              print('bearer removed ' +
                                  response['token'].toString().split(' ')[1]);
                              print(tokenProvider.authToken);
                              dialog.hide();
                              Provider.of<UserTypeProvider>(context).setFirstRunStatus(true,loggingoutStatus: false);  
                                Navigator.pushReplacementNamed(
                                    context, '/select-estate');
                            }
                          }
                          print(response);
                        } catch (error) {
                          print(error);
                          throw error;
                        }
                      }
                    },
                  ),
                ),
                Text("Didn't receive the code?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                FlatButton(
                  child: Text(
                    'Resend the Code',
                    style: TextStyle(color: GateManColors.primaryColor),
                  ),
                  onPressed: () async {
                    dialog.show();
                    try {
                      dynamic response = await AuthService.resendOTOtoken(
                          phone: this.widget.phone);
                      if (response is ErrorType) {
                        await PaysmosmoAlert.showError(
                            context: context,
                            message: GateManHelpers.errorTypeMap(response));
                      } else {
                        await PaysmosmoAlert.showSuccess(
                            context: context,
                            message: 'Verification code has been sent to ' +
                                this
                                    .widget
                                    .email); //' + this.widget.phone + ' and the number ' +

                      }
                    } catch (error) {}
                    dialog.hide();
                  },
                )
              ],
            )
          ],
        ),
      ]),
    );
  }

  InputDecoration tokenBoxDecoration() {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: GateManColors.primaryColor,
              width: 1,
            )));
  }
}
