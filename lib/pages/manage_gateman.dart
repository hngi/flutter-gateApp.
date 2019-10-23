import 'package:flutter/material.dart';
import 'package:gateapp/core/service/resident_service.dart';
import 'package:gateapp/pages/add_gateman.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/GateManExpansionTile/gateman_expansion_tile.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';
class ManageGateman extends StatelessWidget {
  int pendingNumber = 0;
  @override
  Widget build(BuildContext context) {
    pendingNumber =0;
    Future gateman = loadGateManThatArePending(context);
    if(getResidentsGateManProvider(context).initialResidentsGateManLoaded==false){
      print('trying to get initial accepted agteman');
      loadGateManThatAccepted(context);

    }
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
      body: ListView(
        children: <Widget>[
          
         /* getResidentsGateManProvider(context).residentsGManModels.length!=0?ListView(shrinkWrap: true,
            
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: getResidentsGateManProvider(context).residentsGManModels.length==0?<Widget>[
              Container(width: 0,height:0,)// SizedBox(height: 20.0),
            ]:buildChildren(context),
          ):*/
          Center(
            child:Padding(
              padding: const EdgeInsets.only(top:60.0, bottom:60.0),
              child: Text("You do not have any gateman\nadded to your list", style: TextStyle(color: Colors.grey, fontSize: 19.0, fontWeight:FontWeight.w600 ), textAlign: TextAlign.center,),
            )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10.0),
              child: getResidentsGateManProvider(context).residentsGManModels.length!=0?Text('Pending(${getResidentsGateManProvider(context).residentsGManModels.length})', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),):Text('Pending(0)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),),
            ),
            getResidentsGateManProvider(context).residentsGManModels.length!=0?ListView(shrinkWrap: true,
            
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: getResidentsGateManProvider(context).residentsGManModels.length==0?<Widget>[
              Container(width: 0,height:0,)// SizedBox(height: 20.0),
            ]:buildChildren(context),
          ):Container()
        ],
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

  List<Widget> buildChildren(BuildContext context){

    return getResidentsGateManProvider(context).residentsGManModels.map((model){
      return GateManExpansionTile(dutyTime: 'morning', fullName: model.name??'not set',
      phoneNumber: model.phone??'not set', onDeletePressed: (){deleteGateMan(context, model);}, onMessagePressed: null,//will change when implemented in backend
       onPhonePressed:(){ launchCaller(context: context, phone: model.phone);});


    }).toList();

    
  }

  Future deleteGateMan(BuildContext context,ResidentsGateManModel gateManModel,{bool fromAccepted = true}) async{
    try{
      print('sending delete request');
      dynamic response = await ResidentsGatemanRelatedService.removeGateman(gatemanId: gateManModel.id, authToken: await authToken(context));
    print(response);
    if(response is ErrorType){
      PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
    } else {
      if(fromAccepted==true){
        getResidentsGateManProvider(context).deleteResidentsGateManFromAccepted(gateManModel);
      } else {
          getResidentsGateManProvider(context).deleteResidentsGateManFromPending(gateManModel);
      }
        PaysmosmoAlert.showSuccess(context: context, message: 'Succesfully removed '+ gateManModel.name);
    }
    }catch(error){
        throw error;
    }
  }

  Future loadGateManThatAccepted(context) async{
    try{
      dynamic response = await ResidentsGatemanRelatedService.getGateManThatAccepted(authToken: await authToken(context));
      if(response is ErrorType){
        PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
      } else {

        print(response);

        List<dynamic> responseData = response['data'];
        List<ResidentsGateManModel> models= [];
        responseData.forEach((jsonModel){
          models.add(ResidentsGateManModel.fromJson(jsonModel));
          
        });
        getResidentsGateManProvider(context).setResidentsGateManModels(models);
      }
    }catch(error){
      throw error;
    }
  }
  Future loadGateManThatArePending(context) async{
    try{
      dynamic response = await ResidentsGatemanRelatedService.getGateManThatArePending(authToken: await authToken(context));
      if(response is ErrorType){
        PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
      } else {

        print(response);

        List<dynamic> responseData = response['data'];
        List<ResidentsGateManModel> models= [];
        responseData.forEach((jsonModel){
          models.add(ResidentsGateManModel.fromJson(jsonModel));
          
        });

        getResidentsGateManProvider(context).setResidentsGateManModels(models);
        return models;
      }
    }catch(error){
      throw error;
    }
  }
}
