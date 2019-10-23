import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/gateman/widgets/invitationTile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GatemanNotifications extends StatefulWidget {

  @override
  _GatemanNotificationsState createState() => _GatemanNotificationsState();
}

class _GatemanNotificationsState extends State<GatemanNotifications> {
  String imageLocation = 'assets/images/gateman/menu.png';
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
      bottomNavigationBar: CustomBottomAppBar(
        alertText: '${_notifications.length}',
        onTapLocation: '/menu',
        nameOfLocation: 'Menu',
        imageLocation: imageLocation,
      ),
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
