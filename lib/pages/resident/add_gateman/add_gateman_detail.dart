import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateapp/pages/resident/add_gateman/widgets/progress_loader.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'dart:async';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';

enum AddGateManDetailStatus {
    NONE, SEARCHING, MESSAGE_SENT, AWAITING_CONFIRMATION
}

class AddGateManDetail extends StatefulWidget{
  
  @override
  _AddGateManDetailState createState() => _AddGateManDetailState();
}

class _AddGateManDetailState extends State<AddGateManDetail> with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController;
  double angle;
  AddGateManDetailStatus loadingState = AddGateManDetailStatus.NONE;
  @override
  void initState(){
    super.initState();
    _textEditingController = TextEditingController(text: '');


     }   
    
   
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Add Gateman'),
      body: Stack(
              children: <Widget>[Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[  
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('* Phone Number',style:TextStyle(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.only(top:4),
                    child: CustomInputField(hint: '', keyboardType: TextInputType.phone, prefix: null,
              textEditingController: _textEditingController,

              ),
                  )
                ],
              ),
            ),
            
            Container(
              height: 40,
              margin: EdgeInsets.all(20),
              child: FlatButton(child: Text('Continue',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),), onPressed: () {
                
                            //  Future.delayed(Duration(seconds: 2),(){
                               
                            //  });
                           },
                           color: GateManColors.primaryColor,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
               
                           ),
                         )
                       ],
                     ),
                     Center(
                                            child: Container(
          child: new Container(
            margin: EdgeInsets.only(left: 20,right: 20),

            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[Text('Searching for ' + '080766664'),ProgressLoader()],
                
              ),
            ),
          ),
        ),
                     )
              ]),
                 );
               }
               
               void setLoadingState(AddGateManDetailStatus status) {
                 setState((){
                    loadingState = status;
                 });
               }
}