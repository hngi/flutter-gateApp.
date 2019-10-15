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
  AddGateManDetailStatus loadingState = AddGateManDetailStatus.SEARCHING;
  @override
  void initState(){
    super.initState();
    _textEditingController = TextEditingController(text: '');


     }   
    
   
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Add Gateman'),
      body: Column(
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
                            _showMaterialDialog(context, _textEditingController.value);
                            //  setState(() {
                            //      loadingState = AddGateManDetailStatus.SEARCHING;
                            //    });
                             
                           },
                           color: GateManColors.primaryColor,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
               
                           ),
                         )
                       ],
                     ),
                     
              
                 );
               }
               
               void setLoadingState(AddGateManDetailStatus status) {
                 setState((){
                    loadingState = status;
                 });
               }

                Future _showMaterialDialog(context, phoneNumber) async {
          await showDialog(
        context: context,
        builder: (context) {
          
          return StatefulBuilder(
            
             builder: (BuildContext context, setState) {
               return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:loadingState==AddGateManDetailStatus.SEARCHING?<Widget>[Text('Searching for ' + '080766664'),
                        ProgressLoader()]:loadingState==AddGateManDetailStatus.MESSAGE_SENT?<Widget>[

                          Image.asset('assets/images/gateman/ok.png'),
                          Text('Message Sent')


                        ]:loadingState==AddGateManDetailStatus.AWAITING_CONFIRMATION?<Widget>[
                          Image.asset('assets/images/gateman/ok.png'),
                          Text('Message Sent')
                        ]:<Widget>[Container(width: 0,height: 0)]
                    
                  ),
                ),
              );
             },
          );
         
        });
  }

  _dismissDialog(context) {
    Navigator.pop(context);
  }
}