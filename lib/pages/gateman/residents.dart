import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/models/request.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/welcome.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/gateman/widgets/residentTile.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
import 'package:gateapp/utils/helpers.dart';

import '../../core/service/profile_service.dart';
import '../../providers/profile_provider.dart';
import '../../utils/GateManAlert/gateman_alert.dart';
import '../../utils/constants.dart';
import '../../utils/errors.dart';


class ResidentsGate extends StatefulWidget {
  @override
  _ResidentsGateState createState() => _ResidentsGateState();
}

class _ResidentsGateState extends State<ResidentsGate> {
  //String name = setInit;
  bool badge = true;
  int _counter = 1;
  bool details = false;
  bool details2 = false;
  void toggle(){
    setState(() {
     details = !details; 
    });
  }
  void toggle2(){
    setState(() {
     details2 = !details2; 
    });
  }
  var _residents = [
    {
      "name": "Janet Thompson",
      "address": "Block 3A, Dele Adebayo Estate",
      "phone": "08038000000",
      "numberVisit" : 1,
      "visitor" : {
        "nameV" : "John Doe",
        "phoneV": "09099886625",
        "descriptionV":"Bald, Tall and ...",
        "etaV":"00:00 - 00:00",
        "verificationV":"QR CODE",
        "visitStatus" : "Approved",
      },
    },
    {
      "name": "Mr. Seun Adeyini",
      "address": " Block 3B, Dele Adebayo Estate",
      "phone": "08038000000",
      "numberVisit" : 1,
      "visitor" : {
        "nameV" : "John Doe",
        "phoneV": "09099886625",
        "descriptionV":"Bald, Tall and ...",
        "etaV":"00:00 - 00:00",
        "verificationV":"QR CODE",
        "visitStatus" : "Approved",
      },
    },
  ];
  
  var _visitor = {
        "nameV" : "John Doe",
        "phoneV": "09099886625",
        "descriptionV":"Bald, Tall and ...",
        "etaV":"00:00 - 00:00",
        "verificationV":"QR CODE",
        "visitStatus" : "Approved",
  };

  @override
  Widget build(BuildContext context) {

    if (!getRequestProvider(context).initRequests){
      loadRequests(context);
    }
    final wv = MediaQuery.of(context).size.width/100;
    final hv = MediaQuery.of(context).size.width/100;
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Body of the page
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:55.0, left: 20.0),
            child: Text('Welcome $setInitBuildControllers(context)', style: TextStyle(fontSize: 20.0, color: Color(0xff555555), fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Text('Peace Estate', style: TextStyle(fontSize: 14.0, color: Color(0xff49A347), fontWeight: FontWeight.w600,),)
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0, left: 20.0, right: 20.0, bottom: 12.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by Name, Phone, Address, Visitor Info',
                hintStyle: TextStyle(fontSize: 13.0),
                contentPadding: EdgeInsets.all(14.0),
                focusedBorder: GateManHelpers.textFieldBorder,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                border: GateManHelpers.textFieldBorder,
              ),
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0, bottom: 10.0),
            child: Text('ResidentsGate', style: TextStyle(fontSize: 14.0, color: Color(0xff49A347), fontWeight: FontWeight.w600,),)
          ),
           
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(height: 400.0,
                  child: ListView.builder(shrinkWrap: true, physics: ScrollPhysics(),
        itemCount: getNumberOfRequests(context),
        itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: ResidentTile(
                      name: _residents[index]['name'],
                      /*address: _residents[index]['address'],
                      phone: _residents[index]['phone'],
                      numberVisit: 1,
                      visitStatus: _visitor['nameV'],
                      verificationV: _visitor['verificationV'],
                      descriptionV: _visitor['descriptionV'],
                      etaV: _visitor['etaV'],
                      phoneV: _visitor['phoneV'],
                      nameV: _visitor['nameV'],*/
                    ),
                  );
        },
      ),
                ),
              ),
            ],
          ),
          

          SizedBox(height: 60,)
        ],
      ),

    );
  }
  String setInitBuildControllers(BuildContext context) {
    ProfileModel model = getProfileProvider(context).profileModel;
    String name = model.name;
    return name;
  }

  int getNumberOfRequests(BuildContext context) {
    return getRequestProvider(context).requests;
  }

  Future loadRequests(BuildContext context) async {
    try{
      dynamic response  = await GatemanService.getAllRequests(
          authToken: await authToken(context)
      );
      if(response is ErrorType){
        if(response == ErrorType.no_requests_available){
          getRequestProvider(context).setInitStatus(true);
          await PaysmosmoAlert.showSuccess(context: context, message: GateManHelpers.errorTypeMap(response));
        } else{
          await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
        }
      }else{
        if (response['data']['data'] == 0){
          await PaysmosmoAlert.showSuccess(context: context, message: 'No requests');
        } else{
          await PaysmosmoAlert.showSuccess(context: context, message: 'Welcome back');
          print(response['data']['data']);
          dynamic jsonRequests = response['data']['data'];
          List<Resident> requests = [];
          //List<List<Resident>> requestList = [];
          jsonRequests.forEach((jsonModel){requests.add(Resident.fromJson(jsonModel));});
          //requestList.forEach((requests)=> requestList.add(requests));
          getRequestProvider(context).addRequestModels(response);
          getProfileProvider(context).setInitialStatus(true);
        }
      }
    } catch (error){
      print(error);
      await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(ErrorType.generic));

    }

  }

}
