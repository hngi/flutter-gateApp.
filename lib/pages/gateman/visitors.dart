import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gateapp/core/models/visitor.dart';
import 'package:gateapp/core/models/visitor_tile_model.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/widgets/visitorTile.dart';
import 'package:gateapp/providers/gateman_requests_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_visitor_provider.dart';
import 'package:gateapp/utils/Loader/loader.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
import 'package:gateapp/utils/helpers.dart';

import 'scheduledVisit.dart';
import 'widgets/bottomAppbar.dart';
import 'widgets/customFab.dart';


class VisitorsList extends StatefulWidget {
  
  @override
  _VisitorsListState createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  //String name = 'Danny Evans';
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


//  var _visitors = ;
  /*[

    {
      "name": "Mr. Seun Adeyini",
      "address": "Block 3A, Dele Adebayo Street",
      "time": "Morning",
      "color": Color(0xffFFDA58),
    },
    {
      "name": "Mr. Seun Adeyini",
      "address": "Block 3A, Dele Adebayo Street",
      "time": "Morning",
      "color": Color(0xffFFDA58),
    },
    {
      "name": "Mrs. Ambibola",
      "address": "Block 4B, Dele Adebayo Street",
      "time": "Afternoon",
      "color": Color(0xffDCF6E2),
    },
    {
      "name": "Mr. Seun Adeyini",
      "address": "Block 3A, Dele Adebayo Street",
      "time": "Afternoon",
      "color": Color(0xffDCF6E2),
    },
    {
      "name": "Mr. Seun Adeyini",
      "address": "Block 3A, Dele Adebayo Street",
      "time": "Evening",
      "color": Color(0xff94C7FE),
    },
  ];
  */
  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery.of(context).size.height/100;
    ProfileModel profileModel = setMenuModel(context);
    List<VisitorTileModel> visitorTileModel = List<VisitorTileModel>();
    _listOfResidents.forEach((visitorModel){
      visitorTileModel.forEach((tileModel){
        tileModel.name = visitorModel.name;
        tileModel.address = visitorModel.phoneNo;
        tileModel.time = visitorModel.timeIn;
      });
    });
    return Scaffold(
      body: isLoaded
          ? Loader.show()
      : ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top:35.0, left: 20.0, bottom: 5.0),
              child: Text('Welcome ${profileModel.name}', style: TextStyle(fontSize: 22.0, color: Color(0xff49A347), fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Text('Input place numbers of visitors with cars', style: TextStyle(fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w500,),)
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0, left: 20.0, right: 20.0, bottom: 12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search by Plate number or full name',
                  hintStyle: TextStyle(fontSize: 13.0),
                  contentPadding: EdgeInsets.all(14.0),
                  focusedBorder: GateManHelpers.textFieldBorder,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  border: GateManHelpers.textFieldBorder,
                ),
              ),
              
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(height: 400.0,
                    child: ListView.builder(
                      
        itemCount: visitorTileModel.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: VisitorTile(
                      name: visitorTileModel.single.name,
//                      address: _visitors[index]['address'],
//                      time: _visitors[index]['time'],
//                      color: _visitors[index]['color'],
                      func: (){Navigator.pushNamed(context, '/scheduled-visit');},),
          );
        },
      ),
                  ),
                ),
              ],
            ),

        ],
      ),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        alertText: '${_listOfResidents.length}',
        nameOfLocation: 'Menu',
        onTapLocation: '/menu',
        imageLocation: imageLocation,
      ),
    );
  }
}
