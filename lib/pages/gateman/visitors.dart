import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/visitorTile.dart';
import 'package:gateapp/providers/gateman_requests_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_visitor_provider.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/helpers.dart';

import 'scheduledVisit.dart';
import 'widgets/bottomAppbar.dart';
import 'widgets/customFab.dart';

class VisitorsList extends StatefulWidget {
  @override
  _VisitorsListState createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  String imageLocation = 'assets/images/gateman/menu.png';
  var _visitors = [
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

  @override
  Widget build(BuildContext context) {
    int numberOfRequests = 0;
    final hv = MediaQuery.of(context).size.height / 100;
    ProfileModel profileModel = setMenuModel(context);
    if (!getRequestProvider(context).requestLoaded) {
      loadRequests(context);
      if (!getRealVisitorProvider(context).isLoaded) {
        loadVisitorsList(context);
      }
    }

    RealVisitorModel visitorModel = RealVisitorModel();
    visitorModel = getRealVisitorProvider(context).visitorModel;
    if(getRequestProvider(context).requestModel == null){
      numberOfRequests = 0;
    } else {
      numberOfRequests = getRequestProvider(context).requestModel.requests;
    }
    //dynamic _visitors = visitorModel;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, bottom: 5.0),
            child: Text('Welcome ${profileModel.name}',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xff49A347),
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Input place numbers of visitors with cars',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 12.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by Plate number or full name',
                hintStyle: TextStyle(fontSize: 13.0),
                contentPadding: EdgeInsets.all(14.0),
                focusedBorder: GateManHelpers.textFieldBorder,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                border: GateManHelpers.textFieldBorder,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 400.0,
                  child: ListView.builder(
                    itemCount: (numberOfRequests == 0) ? 1 : _visitors.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (numberOfRequests == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                            margin: EdgeInsets.only(left: 30.0, right: 20.0),
                            child: new Text(
                              'No Visitors Yet',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: VisitorTile(
                            name: _visitors[index]['name'],
                            address: _visitors[index]['address'],
                            time: _visitors[index]['time'],
                            color: _visitors[index]['color'],
                            func: () {
                              Navigator.pushNamed(context, '/scheduled-visit');
                            },
                          ),
                        );
                      }
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
        alertText: '$numberOfRequests',
        nameOfLocation: 'Menu',
        onTapLocation: '/menu',
        imageLocation: imageLocation,
      ),
    );
  }
}
