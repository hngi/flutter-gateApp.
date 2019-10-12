import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationResident extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Notifications'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  'Visitors',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 160.0),
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
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  'Samuel Charles has arrived',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 95.0),
                child: PopupMenuButton(
                    offset: Offset(0, 100),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text("Delete",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                            subtitle: Text(
                              'Delete this notification',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          )),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.notifications_off),
                              title: Text(
                                "Turn off",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                'Turn off this notification',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ]),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only( left: 20.0),
                child: Text(
                  '5 Mins ago',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
            Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text(
                  'Invites',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),             
            ],
          ),
          Row(
            children: <Widget>[
              
              Container(
                padding: EdgeInsets.only( top:10.0, left: 20.0),
                child: Text(
                  'Idris Abdulkareem accepted to  be your\n gateman',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only( left: 10.0),
                child: PopupMenuButton(
                    offset: Offset(0, 100),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text("Delete",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                            subtitle: Text(
                              'Delete this notification',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          )),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.notifications_off),
                              title: Text(
                                "Turn off",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                'Turn off this notification',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ]),
              )
              
              
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only( top:10.0,left: 20.0),
                child: Text(
                  '10 Mins ago',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          // Navigator.pushReplacementNamed(context, '/homepage');
        },
        icon: MdiIcons.account,
        title: 'Residents',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          print("leading clicked");
          Navigator.pushNamed(context, '/homepage');
        },
        onTrailingClicked: () {},
      ),
    );
  }
}
