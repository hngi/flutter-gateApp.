



import 'package:flutter/material.dart';
import 'package:gateapp/core/service/auth_service.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:provider/provider.dart';

class TokenConfirmation extends StatefulWidget{
  @override
  _TokenConfirmationState createState() => _TokenConfirmationState();
}

class _TokenConfirmationState extends State<TokenConfirmation> {
  TextEditingController firstTokenController = TextEditingController(text: '');
  TextEditingController secondTokenController = TextEditingController(text: '');
  TextEditingController thirdTokenController =  TextEditingController(text: '');
  TextEditingController fourthTokenController  = TextEditingController(text: '');
  TextEditingController fifthTokenController = TextEditingController(text: '');
  TextEditingController sixthTokenController =  TextEditingController(text: '');

  FocusNode firstFocusNode = FocusNode(canRequestFocus: true);
  FocusNode secondFocusNode = FocusNode(canRequestFocus: true);
  FocusNode thirdFocusNode = FocusNode(canRequestFocus: true);
  FocusNode fourthFocusNode = FocusNode(canRequestFocus: true);
  FocusNode fifthFocusNode = FocusNode(canRequestFocus: true);
  FocusNode sixthFocusNode = FocusNode(canRequestFocus: true);
  List<TextEditingController> get getControllers {return [
    firstTokenController,secondTokenController,thirdTokenController,
  fourthTokenController,fifthTokenController,sixthTokenController

  ];} 

  List<FocusNode> get getFocusNodes {
    return [
      firstFocusNode, secondFocusNode, thirdFocusNode,fourthFocusNode,fifthFocusNode,
      sixthFocusNode


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
    getControllers.forEach((f){
      f.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TokenProvider tokenProvider =
        Provider.of<TokenProvider>(context, listen: false);
    // TODO: implement build
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Verify Account'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Please enter the 4 digit verification code sent to.'),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getControllers.map((controller){
                          return Container(
                        width: 50,
                        height: 50,
                        child: Center(child: TextField(decoration: tokenBoxDecoration(),
                        focusNode: getFocusNodes[getControllers.indexOf(controller)],
                        onChanged: (str){
                          if (str.length == 1){
                            if(getControllers.indexOf(controller)+1<6){
                              FocusScope.of(context).requestFocus(getFocusNodes[getControllers.indexOf(controller)+1]);
                            
                            }
                            
                          }
                        },
                          controller: controller,
                          textAlign: TextAlign.center,),
                        ));
                      
                    }).toList()
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
                                      child: FlatButton(child: Text('Verify',style: TextStyle(color:Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      color: GateManColors.primaryColor,
                                      onPressed: () async{
                                        LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                                        dialog.show();
                                          
                                        try{
                                          String otpCode = firstTokenController.text +
                                          secondTokenController.text+thirdTokenController.text+
                                          fourthTokenController.text+fifthTokenController.text+
                                          sixthTokenController.text;
                                          print(otpCode);
                                          dynamic response = await AuthService.verifyAccount(verificationCode: otpCode);
                                          if(response is ErrorType){
                                          if(response == ErrorType.account_already_verified){

                                            //dynamic loginResponse = await AuthService.loginUser(phone: null);
                                            dialog.hide();
                                            if (await userType(context)==user_type.RESIDENT){
                                          Navigator.pushReplacementNamed(context, '/welcome-resident');
                                            } else{
                                              Navigator.pushReplacementNamed(context, '/gateman_menu');
                                            }

                                          } else{

                                            dialog.hide();
                                            PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap[response]);
                                          }
                                          }else{
                                          if (response['token'].length > 0){
                                             print(response['token']);
                                          tokenProvider.setToken(response['token'].toString().split(' ')[1]);
                                          print(tokenProvider.authToken);
                                          dialog.hide();
                                            if (await userType(context)==user_type.RESIDENT){
                                          Navigator.pushReplacementNamed(context, '/welcome-resident');
                                            } else{
                                              Navigator.pushReplacementNamed(context, '/gateman_menu');
                                            }

                                          }} 
                                          print(response);
                                        } catch(error){
                                          print(error);
                                          throw error;
                                        }
                                      },),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      
                        InputDecoration tokenBoxDecoration() {
                          return InputDecoration(
                            
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: GateManColors.primaryColor,width:1,)
                            )
                          );
                        }
}