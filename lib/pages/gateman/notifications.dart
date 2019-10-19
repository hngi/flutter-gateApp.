import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/gateman/widgets/invitationTile.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/pages/gateman/residents.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu.dart';

class GatemanNotifications extends StatefulWidget {

  @override
  _GatemanNotificationsState createState() => _GatemanNotificationsState();
}

class _GatemanNotificationsState extends State<GatemanNotifications> {
  bool badge = true;
  int _counter = 1;
  var _notifications = [
    {
      "name": "Janet Thompson",
      "address": "Block 3A, Dele Adebayo Estate",
      "phone": 08038000000,
    },
    {
      "name": "Mark Evans",
      "address": "UB junction, Molyko Estate",
      "phone": 07865412876,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final wv = MediaQuery.of(context).size.width / 100;
    final hv = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.dotsVertical),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return InvitationTile(
            rname: _notifications[index]['name'],
            raddress: _notifications[index]['address'],
            rphone: _notifications[index]['phone'],
            func: () {
              Navigator.pushNamed(context, '/residents-gate');
            },
          );
        },
      ),
    );
  }
}
