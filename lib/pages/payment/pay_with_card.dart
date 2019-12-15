
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rave_flutter/src/ui/fields/card_number_field.dart';
import 'package:xgateapp/pages/payment/widgets/rave_logo.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:rave_flutter/src/ui/common/input_formatters.dart';
import 'package:rave_flutter/src/ui/common/card_utils.dart';

class PayWithCard extends StatefulWidget{
  @override
  _PayWithCardState createState() => _PayWithCardState();
}

class _PayWithCardState extends State<PayWithCard> {
  String _cardNumber;
  StreamController<String> _cardNumberController ;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardNumberController = StreamController<String>();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
              child: Container(
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
            payWithTile(title: 'Pay With Card',isCollapsed:false),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:16.0,right: 16.0),
                      child: CustomTextFormField(
                        labelName: 'Card Number',
                        onChanged: (String nS){
                          _cardNumberController.sink.add(nS);
                        },
                         onSaved: (String numb) {
                        
                          setState((){
                            _cardNumber = numb;
                          });
                          
                        },
                         validator: (String){},
                        inputFormatters: [CardNumberInputFormatterGateApp(),
                        LengthLimitingTextInputFormatter(22),],
                        keyboardType: TextInputType.number,suffixIcon: StreamBuilder<String>(
                          stream: _cardNumberController.stream,
                          builder: (context, snapshot) {
                            getCardImage(CardUtils.getTypeForIIN(snapshot.data));
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(snapshot == null || snapshot.data == null ||snapshot.data.length == 0 ?'assets/images/card-unknown.png':getCardImage(CardUtils.getTypeForIIN(snapshot.data)),scale: 4,),
                            );
                          }
                        ),
                                              ),
                                            ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                                                            child: CustomTextFormField(
                                                  labelName: 'Valid till MM/YY', onSaved: (String ) {}, validator: (String ) {},
                                                  inputFormatters: [CardMonthInputFormatterGateApp(),LengthLimitingTextInputFormatter(5) ],
                                                  keyboardType: TextInputType.number,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                            child: CustomTextFormField(
                                                  labelName: 'CVV/CVV2', onSaved: (String ) {}, validator: (String ) {},
                                                  inputFormatters: [LengthLimitingTextInputFormatter(3)],keyboardType: TextInputType.number,

                                                ),
                                              ),
                                            )
                                          ],),
                                          Padding(
                                            padding: const EdgeInsets.only(left:10.0,right:10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                              Text('Save Card'),
                                              Switch(onChanged: (bool value) {}, value: false,


                                              ),

                                            ],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                print('tapped');
                                              }, child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                               color: GateManColors.primarySwatchColor
                                                ),
                                                height: 50,
                                                child: Center(child: Text('Pay',textAlign:TextAlign.center,style:TextStyle(fontSize:10,color: Colors.white)))),
                                              
                                            ),
                                          ),
                                          raveLogo
                        
                                          ],
                        
                                        ),
                                      ),
                                      payWithTile(title:'Pay from Account',isCollapsed: true)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        
                          String getCardImage(CardType typeForIIN) {
                            switch (typeForIIN) {
                              case CardType.visa:
                                return 'assets/images/card-visa.png';
                              case CardType.master:
                                return 'assets/images/card-mastercard.png';
                              
                              case CardType.verve:
                                return 'assets/images/card-verve.png';
                              case CardType.unknown:
                                return 'assets/images/card-unknown.png';
                              
                                break;
                              default:
                              return 'assets/images/card-unknown.png';
                            }
                          }
}

class CardNumberInputFormatterGateApp extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) { 
        
        if(newValue.text.length < 4 || oldValue.text.length>newValue.text.length){
          return newValue;
        }
        String acting = newValue.text.replaceAll('  ', '');
        String newS = '';
        int count = 0;
        for (int i=0;i<acting.length;i++){
          count +=1;
          newS = newS + acting[i];
          if (count == 4){
            newS = newS + '  ';
            count = 0;
          }
        }
        return newValue.copyWith(text: newS,selection: TextSelection.collapsed(offset: newS.length));
  }
}

class CardMonthInputFormatterGateApp extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) { 

        if(newValue.text.length < 2 || oldValue.text.length>newValue.text.length){
          return newValue;
        }
        String acting = newValue.text.replaceAll('/', '');
        String newS = '';
        int count = 0;
        for (int i=0;i<acting.length;i++){
          count +=1;
          newS = newS + acting[i];
          if (count == 2){
            newS = newS + '/';
            count = 0;
          }
        }
        return newValue.copyWith(text: newS,selection: TextSelection.collapsed(offset: newS.length));
  }
}

Widget payWithTile({bool isCollapsed = true, String title}){
  return Container(
                height: 50,
                color: GateManColors.primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('$title',style: TextStyle(color: Colors.white,fontSize: 14)),
                      ),
                      IconButton(icon: Icon(isCollapsed?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down),onPressed: (){},color: Colors.white,)
                    ],
                  ),
               
                
              );
}