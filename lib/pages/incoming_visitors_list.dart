import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:xgateapp/widgets/IncomingVisitorListTile/incoming_visitor_list_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IncomingVisitorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(bottom: 23.0),
            child: Text('Welcome Mr. Danny',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text('Incoming Visitors',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                )),
          ),
          Text('Today',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              )),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "09:00am",
            visitingTime: VisitingTime.morning,
          ),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "01:45pm",
            visitingTime: VisitingTime.afternoon,
          ),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "06:30pm",
            visitingTime: VisitingTime.evening,
          ),
          SizedBox(height: 20.0),
          Text('Yesterday',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              )),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "01:45pm",
            visitingTime: VisitingTime.afternoon,
          ),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "06:30pm",
            visitingTime: VisitingTime.evening,
          ),
          SizedBox(height: 20.0),
          Text('21-09-2019',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              )),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "01:45pm",
            visitingTime: VisitingTime.afternoon,
          ),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "06:30pm",
            visitingTime: VisitingTime.evening,
          ),
          IncomingVisitorListTile(
            fullName: "Mr. Seun Adeniyi",
            estateName: "Peace Estate",
            time: "06:30pm",
            visitingTime: VisitingTime.evening,
          ),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/residents');
        },
        icon: MdiIcons.accountPlus,
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
          Navigator.pushNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
