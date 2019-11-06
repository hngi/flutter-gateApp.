import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/core/models/user.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/pages/gateman/widgets/visitorTile.dart';
import 'package:xgateapp/pages/gateman_menu.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';

import 'scheduledVisit.dart';
import 'widgets/bottomAppbar.dart';
import 'widgets/customFab.dart';


class VisitorsList extends StatefulWidget {
  
  @override
  _VisitorsListState createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  bool visitorsExist = false;
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
  
bool isLoading = false;

  List<GatemanResidentVisitors> _residents = [];
  LoadingDialog dialog;
  int _alerts = 0;

  @override

  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
    initApp();
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });
    Future.wait([
      GatemanService.allResidentVisitors(
        authToken: await authToken(context),
      ),
      GatemanService.allRequests(authToken: await authToken(context)).then((alerts){
        print(alerts);
        setState(() {
          _alerts = alerts.length;
        });
      }),
    ]).then((res) {
      print(res);
      
      setState(() {
        _residents = res[0];

        isLoading = false;
      });
      print("$_residents jkfnkjzenfkjerznflejkrngizlegioeugoheugeriugigherughghererghierguiuhgruhierhgiuerg");
    });
  }


  Widget build(BuildContext context) {
    visitorsExist ? print("$_residents jkfnkjzenfkjerznflejkrngizlegioeugoheugeriugigherughghererghierguiuhgruhierhgiuerg"): print("ok");
    final hv = MediaQuery.of(context).size.height/100;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top:35.0, left: 20.0, bottom: 5.0),
              child: Text(getProfileProvider(context)
                                         .profileModel
                                         .name==null?'Welcome, ...':'Welcome, ' + getProfileProvider(context)
                                         .profileModel
                                         .name.toString(), style: TextStyle(fontSize: 22.0, color: Color(0xff49A347), fontWeight: FontWeight.w600)),
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
            /*visitorsExist ? Row(
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
                      func: (){},),
          );
        },
      ),
                  ),
                ),
              ],
            ) : Container(
              child: Center(child: Padding(
                padding: const EdgeInsets.only(top:60.0),
                child: Text('No visitors awaited', style: TextStyle(fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.w600),),
              )),
            ),*/

            _residents == null || _residents.length == 0
                    ? Container(
              child: Center(child: Padding(
                padding: const EdgeInsets.only(top:60.0),
                child: Text('No visitors awaited', style: TextStyle(fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.w600),),
              )),
            )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _residents.map((GatemanResidentVisitors visitor) {
                          User resident = visitor.user;

                          return Padding(
                            padding: const EdgeInsets.only(top:8.0, bottom:8.0),
                            child: VisitorTile(
                              name: '${visitor.name}',
                              address: '${visitor.phoneNo}',
                              time:
                                  '${visitor.visitingPeriod}',
                              color: Colors.blueGrey.withOpacity(0.2),
                              func: (){
                                Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduledVisit(
              name:'${visitor.name}',
                                  phone:'${visitor.phoneNo}',
                                  description:'${visitor.description}',
                                  eta:'${visitor.createdAt}',
                                  verification:'QR Code',
                                  visitStatus:'${visitor.qrCode}',
            ),
          ),
        );
                              },
                            ),
                          );
                        }).toList(),
                      ),

        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => GateManMenu()));
        },
        icon: MdiIcons.accountGroup,
        title: 'Residents',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          Navigator.pushNamed(context, '/gateman-menu');
        },
        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
