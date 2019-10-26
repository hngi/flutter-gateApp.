import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gateapp/core/models/gateman_resident_visitors.dart';
import 'package:gateapp/core/models/visitor.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/welcome.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/gateman/widgets/residentTile.dart';
import 'package:gateapp/providers/gateman_requests_provider.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_visitor_provider.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/helpers.dart';

class ResidentsGate extends StatefulWidget {
  @override
  _ResidentsGateState createState() => _ResidentsGateState();
}

class _ResidentsGateState extends State<ResidentsGate> {
  //String name = '';
  String imageLocation = 'assets/images/gateman/menu.png';

  bool isLoaded = false;
  List<GatemanResidentVisitors> _listOfResidents = [];
  LoadingDialog loader;

  @override
  void initState(){
    super.initState();
    loader = LoadingDialog(context, LoadingDialogType.Normal);
    initApp();
  }

  initApp() async {
    setState(() {
      isLoaded = true;
    });

    Future.wait([
      /*GateManService.allResidentVisitors(
        authToken: await authToken(context),*/
      GateManService.allResidentVisitors(authToken: await authToken(context),)

    ]).then((x){
      print(x);
      setState(() {
        _listOfResidents = x[0];
        isLoaded = false;
      });
    });
  }

  var _visitor = {
    "nameV": "John Doe",
    "phoneV": "09099886625",
    "descriptionV": "Bald, Tall and ...",
    "etaV": "00:00 - 00:00",
    "verificationV": "QR CODE",
    "visitStatus": "Approved",
  };

  @override
  Widget build(BuildContext context) {
    String imageLocation = 'assets/images/gateman/menu.png';
    final wv = MediaQuery.of(context).size.width / 100;
    final hv = MediaQuery.of(context).size.width / 100;
    int numberOfRequests = _listOfResidents.length;
    int numberOfVisitors = 0;
    ProfileModel profileModel = setMenuModel(context);
/*    if(!getRequestProvider(context).requestLoaded){
      loadRequests(context);
      if(!getRealVisitorProvider(context).isLoaded){
        loadVisitorsList(context);
      }
    }
    RequestModel requestModel = RequestModel();
    RealVisitorModel visitorModel = RealVisitorModel();
    visitorModel = getRealVisitorProvider(context).visitorModel;
    requestModel = getRequestProvider(context).requestModel;
    dynamic _residents = requestModel;
    dynamic _visitors = visitorModel;
    while(requestModel != null){
       _residents = json.decode(requestModel.residents.toString());
        numberOfRequests = requestModel.requests;
    }*/
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
        alertText: '$numberOfRequests',
        onTapLocation: '/menu',
        nameOfLocation: 'Menu',
        imageLocation: imageLocation,),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Body of the page
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 55.0, left: 20.0),
            child: Text('Welcome ${profileModel.name}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff555555),
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Peace Estate',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff49A347),
                  fontWeight: FontWeight.w600,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 12.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by Name, Phone, Address, Visitor Info',
                hintStyle: TextStyle(fontSize: 13.0),
                contentPadding: EdgeInsets.all(14.0),
                focusedBorder: GateManHelpers.textFieldBorder,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                border: GateManHelpers.textFieldBorder,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(
                'Residents',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff49A347),
                  fontWeight: FontWeight.w600,
                ),
              )),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 400.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: (_listOfResidents == null)? 1 : numberOfRequests,
                    itemBuilder: (BuildContext context, int index) {
                      if (_listOfResidents == null){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                            margin: EdgeInsets.only(left: 30.0, right: 20.0),
                            child: new Text(
                              'No Resident Accepted',
                              style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),),
                          ),
                        );
                      } else {
                      return (Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ResidentTile(
                                name: _listOfResidents[index].name,
                                //address: _residents[index]['address'],
                                phone: _listOfResidents[index].phoneNo,
                                //numberVisit: 1,
                                visitStatus: _visitor['nameV'],
                                verificationV: _visitor['verificationV'],
                                descriptionV: _visitor['descriptionV'],
                                etaV: _visitor['etaV'],
                                phoneV: _visitor['phoneV'],
                                nameV: _visitor['nameV'],
                              ),
                            ));
                    }},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
