import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/visitorTile.dart';
import 'package:gateapp/utils/helpers.dart';

import 'scheduledVisit.dart';


class VisitorsList extends StatefulWidget {
  
  @override
  _VisitorsListState createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  String name = 'Danny Evans';
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
    final hv = MediaQuery.of(context).size.height/100;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top:55.0, left: 20.0, bottom: 5.0),
              child: Text('Welcome $name', style: TextStyle(fontSize: 20.0, color: Color(0xff49A347), fontWeight: FontWeight.w600)),
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
                      
        itemCount: _visitors.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: VisitorTile(
                      name: _visitors[index]['name'],
                      address: _visitors[index]['address'],
                      time: _visitors[index]['time'],
                      color: _visitors[index]['color'],
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
    );
  }
}
