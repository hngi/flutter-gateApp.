import 'package:flutter/material.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/pages/gateman/welcome.dart';
import 'package:xgateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:xgateapp/pages/gateman/widgets/customFab.dart';
import 'package:xgateapp/pages/gateman/widgets/residentTile.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/utils/helpers.dart';


class ResidentsGate extends StatefulWidget {
  @override
  _ResidentsGateState createState() => _ResidentsGateState();
}

class _ResidentsGateState extends State<ResidentsGate> {
  String name = GatemanUserProvider().getFullName();
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
  var _residents = GatemanService.getAllRequests();
  /*[
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
 */
  @override
  Widget build(BuildContext context) {
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
            child: Text('Welcome $name', style: TextStyle(fontSize: 20.0, color: Color(0xff555555), fontWeight: FontWeight.w600)),
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
        itemCount: _residents.length,
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
  
}
