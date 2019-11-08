import 'dart:core';

import 'package:flutter/material.dart';
import 'package:xgateapp/core/service/resident_service.dart';
import 'package:xgateapp/pages/add_gateman.dart';
import 'package:xgateapp/providers/resident_gateman_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/GateManExpansionTile/gateman_expansion_tile.dart';
import 'package:flutter_sms/flutter_sms.dart';
class ManageGateman extends StatefulWidget {
  //static TextEditingController _smsController = new TextEditingController();

  @override
  _ManageGatemanState createState() => _ManageGatemanState();
}

class _ManageGatemanState extends State<ManageGateman> {
  int pendingNumber = 0;

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await FlutterSms
        .sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
  print(_result);
  }

  //String message = ManageGateman._smsController.text;
  //TextEditingController _controller;
  @override
  void initState() {
    //_controller = new TextEditingController(text: 'Hello, i need you as a gateman');
    super.initState();
  }
  
  Widget build(BuildContext context) {
    String nameP = getProfileProvider(context)
                                         .profileModel
                                         .name.toString();
    // Future gateman = loadGateManThatArePending(context);
//     appIsConnected().then((isConnected) {
//       if(isConnected == true){
//         print('app is connected gateman');
// if(getResidentsGateManProvider(context).loadedFromApi==false && getResidentsGateManProvider(context).loadingAccepted !=true){
//       print('trying to get initial accepted agteman');
//       loadGateManThatAccepted(context);
//      }
//      if(getResidentsGateManProvider(context).pendingloadedFromApi == false && getResidentsGateManProvider(context).loadingPending != true){
//        loadGateManThatArePending(context);
//      }
//      }
//     });

    
    
   return /*getResidentsGateManProvider(context).residentsGManModels.length==0?
    AddGateman()
    :*/
    Scaffold(
      appBar: GateManHelpers.appBar(context, 'Manage Gateman'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:18.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: (){Navigator.pushNamed(context, '/add-gateman-detail');
              },
              child: Icon(Icons.add, color: Colors.white, size: 30.0),
              backgroundColor: GateManColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            Text('Add New',style: TextStyle(fontSize: 12),)
          ],
          
        ),
      ),
      body: RefreshIndicator(
              child: ListView(
          children: <Widget>[
            
           getResidentsGateManProvider(context).residentsGManModels.length!=0?ListView(shrinkWrap: true,
              
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              children: getResidentsGateManProvider(context).residentsGManModels.length==0?<Widget>[
                Container(width: 0,height:0,)// SizedBox(height: 20.0),
              ]:buildChildren(context),
            ):Center(
              child:Padding(
                padding: const EdgeInsets.only(top:60.0, bottom:60.0),
                child: Text("You do not have any gateman\nadded to your list", style: TextStyle(color: Colors.grey, fontSize: 19.0, fontWeight:FontWeight.w600 ), textAlign: TextAlign.center,),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
                child: getResidentsGateManProvider(context).residentsGManModelsAwaiting.length!=0?Text('Pending(${getResidentsGateManProvider(context).residentsGManModelsAwaiting.length})', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),):Text('Pending(0)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),),
              ),
              getResidentsGateManProvider(context).residentsGManModelsAwaiting.length!=0?ListView(shrinkWrap: true,
              
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              children: getResidentsGateManProvider(context).residentsGManModelsAwaiting.length==0?<Widget>[
                Container(width: 0,height:0,)// SizedBox(height: 20.0),
              ]:buildChildren(context,useAwaiting: true),
            ):Container()
          ],
        ), onRefresh: (){
          loadGateManThatArePending(context);
          return loadGateManThatAccepted(context);
        },
      ),
      // bottomSheet: Row(
      //   children: <Widget>[
      //     InkWell(
      //       onTap: (){Navigator.pushNamed(context, '/add-gateman');},
      //                 child: Container(
      //         //margin: EdgeInsets.all(34.0),
      //         alignment: Alignment.center,
      //         padding: EdgeInsets.all(8.0),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10.0),
      //           color: GateManColors.primaryColor,
      //         ),
      //         height: 50.0,
      //         width: 50.0,
      //         child: Icon(Icons.add, color: Colors.white, size: 30.0),
      //       ),
      //     ),
      //   ],
    );
  }

  List<Widget> buildChildren(BuildContext context,{useAwaiting=false}){
    TextEditingController smsController = TextEditingController(text: '');
    String nameProfile = getProfileProvider(context).profileModel.name.toString();
    if(useAwaiting==true){
          return getResidentsGateManProvider(context).residentsGManModelsAwaiting.map((model){
      return GateManExpansionTile(dutyTime: 'morning', fullName: model.name??'not set',
      phoneNumber: model.phone??'not set', onDeletePressed: (){deleteGateMan(context, model,fromAccepted: false);}, onMessagePressed: null,//will change when implemented in backend
       onPhonePressed:(){ launchCaller(context: context, phone: model.phone);}, 
       onSmsPressed: (String smss){
         print('heyyyy sms'); 
         _sendSMS("Message from GateGuard by $nameProfile:\n.smss", ["${model.phone}"]);},
         smsController: smsController,);
       }).toList();

    }

    
    

    return getResidentsGateManProvider(context).residentsGManModels.map((model){
      TextEditingController smsController = TextEditingController(text: '');
      return GateManExpansionTile(dutyTime: 'morning', fullName: model.name??'not set',
      phoneNumber: model.phone??'not set', onDeletePressed: (){deleteGateMan(context, model);}, onMessagePressed: null,//will change when implemented in backend
       onPhonePressed:(){ launchCaller(context: context, phone: model.phone);}, 
       onSmsPressed: (String smss){
         _sendSMS("Message from GateGuard by $nameProfile:\n.$context", ["${model.phone}"]);},
         smsController: smsController,/*smsController: ManageGateman._smsController,*/);


    }).toList();

    
  }

  Future deleteGateMan(BuildContext context,ResidentsGateManModel gateManModel,{bool fromAccepted = true}) async{
    LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
    dialog.show();
    try{
      print('sending delete request');
      dynamic response = await ResidentsGatemanRelatedService.removeGateman(gatemanId: gateManModel.id, authToken: await authToken(context));
    print(response);
    if(response is ErrorType){
      PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
    } else {
      print(response);
      if(fromAccepted==true){
        getResidentsGateManProvider(context).deleteResidentsGateManFromAccepted(gateManModel);
      } else {
          getResidentsGateManProvider(context).deleteResidentsGateManFromPending(gateManModel);
      }
        await PaysmosmoAlert.showSuccess(context: context, message: 'Succesfully removed '+ gateManModel.name);
    }
    }catch(error){
        throw error;
    }
    Navigator.pop(context);
  }

  }
