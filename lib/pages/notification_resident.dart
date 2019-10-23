import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/residents_notification.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationResident extends StatefulWidget {
  final String name;
  NotificationResident({this.name});
  @override
  _NotificationResidentState createState() => _NotificationResidentState();
}

class _NotificationResidentState extends State<NotificationResident> {
  var _visitors = [
    {
      "name": "Samuel Charles has Arrived",
      "time": "5mins Ago",
    },
    {
      "name": "Jacob Charles has Arrived",
      "time": "10 mins Ago",
    },
  ];
  var _gatemen = [
    {
      "name": "Grant Chukwu Accepted to be\n your gateman ",
      "time": "5 mins Ago",
    },
    {
      "name": "Grant Chukwu Acceptedto be\n  your gateman ",
      "time": "10 mins Ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Notifications'),
      body: ListView(
        
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 20.0),
                child: Text(
                  'Visitors',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 160.0),
                child: Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: ListView.builder(
                    itemCount: _visitors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ResidentsNotificationList(
                          name: _visitors[index]['name'],
                          time: _visitors[index]['time'],
                          
                        ),
                      );
                    
                    },
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text(
                  'Invites',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
           Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    itemCount: _gatemen.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ResidentsNotificationList(
                          name: _gatemen[index]['name'],
                          time: _gatemen[index]['time'],
                          
                        ),
                      );
                    
                    },
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: MdiIcons.account,
        title: 'Visitors',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          print("leading clicked");
          Navigator.pushReplacementNamed(context, '/homepage');
        },
        onTrailingClicked: () {},
      ),
    );
  }
}