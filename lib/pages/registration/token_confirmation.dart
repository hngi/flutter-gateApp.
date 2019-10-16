



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

  List<TextEditingController> get getControllers {return [
    firstTokenController,secondTokenController,thirdTokenController,
  fourthTokenController,fifthTokenController,sixthTokenController

  ];} 

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
      appBar: GateManHelpers.appBar(context, 'Confirm OTP'),
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
                Text('Enter OTP'),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: firstTokenController,),
                        )
                        ),
                        Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: secondTokenController,),
                        )
                        ),
                        Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: thirdTokenController,),
                        )
                        ),
                        Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: fourthTokenController,),
                        )
                        ),
                        Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: fifthTokenController,),
                        )
                        ),Container(
                        width: 50,
                        height: 50,
                        child: Center(
                                                  child: TextField(decoration: tokenBoxDecoration(),
                          controller: sixthTokenController,),
                        )
                        ),

                    ]
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
                                      child: FlatButton(child: Text('Veify',style: TextStyle(color:Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                                          
                                          if (response['token'].length > 0){
                                             print(response['token']);
                                          tokenProvider.setToken(response['token']);
                                          print(tokenProvider.authToken);
                                          dialog.hide();
                                            if (await userType(context)==user_type.RESIDENT){
                                          Navigator.pushReplacementNamed(context, '/welcome-resident');
                                            } else{
                                              Navigator.pushReplacementNamed(context, '/gateman_menu');
                                            }
                                           
                                          }
                                          else if(response == ErrorType.account_already_verified){
                                            dialog.hide();
                                            if (await userType(context)==user_type.RESIDENT){
                                          Navigator.pushReplacementNamed(context, '/welcome-resident');
                                            } else{
                                              Navigator.pushReplacementNamed(context, '/gateman_menu');
                                            }

                                          }
                                          
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