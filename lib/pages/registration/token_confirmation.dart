import 'package:flutter/material.dart';
import 'package:xgateapp/core/service/auth_service.dart';
import 'package:xgateapp/providers/token_provider.dart';
import 'package:xgateapp/providers/user_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:provider/provider.dart';

class TokenConfirmation extends StatefulWidget {
  String phone;
  // String email;
  bool skipSelectEstate;
  String showAlertMessage;
  TokenConfirmation(
      {this.phone = '08056664098',
      // this.email = 'winninggreat@gmail.com',
      this.skipSelectEstate = false,
      this.showAlertMessage});
  @override
  _TokenConfirmationState createState() => _TokenConfirmationState();
}

class _TokenConfirmationState extends State<TokenConfirmation> {
  TextEditingController firstTokenController = TextEditingController(text: '');
  TextEditingController secondTokenController = TextEditingController(text: '');
  TextEditingController thirdTokenController = TextEditingController(text: '');
  TextEditingController fourthTokenController = TextEditingController(text: '');

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
  List<TextEditingController> get getControllers {return [
    firstTokenController,secondTokenController,thirdTokenController,
  fourthTokenController,

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
      fourthFocusNode,
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
                    'Please enter the 4 digit verification code sent to ' +
                        this.widget.phone.replaceRange(6, 12, '*****'),
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
                                width: 70,
                                height: 70,
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: tokenBoxDecoration(),
                                    obscureText: true,
                                    focusNode: getFocusNodes[
                                        getControllers.indexOf(controller)],
                                    onChanged: (str) {
                                      if (str.length == 1) {
                                        if (getControllers.indexOf(controller) +
                                                1 <
                                            4) {
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
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      'Verify Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: GateManColors.primaryColor,
                    onPressed: () async {
                      String otpCode = firstTokenController.text +
                          secondTokenController.text +
                          thirdTokenController.text +
                          fourthTokenController.text;
                      if (otpCode.length < 4) {
                        await PaysmosmoAlert.showError(
                            context: context,
                            message: 'Token must be 4 digits');
                      } else {
                        dialog.show();

                        // try {
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
                                getUserTypeProvider(context).setLoggedOutStatus(false);

                              dialog.hide();
                              if (this.widget.skipSelectEstate == true){
                                print(await getUserTypeProvider(context).getUserTypeRoute);
                                Navigator.pushReplacementNamed(context, await getUserTypeProvider(context).getUserTypeRoute);
                                Provider.of<UserTypeProvider>(context).setFirstRunStatus(false,loggedOut: false);  
                              } else {
                              Provider.of<UserTypeProvider>(context).setFirstRunStatus(false,loggedOut: false);  
                                Navigator.pushReplacementNamed(
                                    context, '/select-estate');
                              }
                            }
                          }
                          print(response);
                        // } catch (error) {
                        //   print(error);
                        //   throw error;
                        // }
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
                                    .phone); //' + this.widget.phone + ' and the number ' +

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
