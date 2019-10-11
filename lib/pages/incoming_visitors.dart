import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IncomingVisitors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text('Welcome Mr. Danny',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text('Peace Estate',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 16.0,
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
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: GateManColors.primaryColor,
                  style: BorderStyle.solid,
                  width: .7,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Mr. Seun Adeniyi",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: GateManColors.blackColor,
                  ),
                ),
                subtitle: Text(
                  "Designation - Cook",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                trailing: //Add Button
                    Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: GateManColors.yellowColor,
                  ),
                  height: 32.0,
                  width: 70.0,
                  child: Text('Morning',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                ),
              )),
          SizedBox(height: 10.0),
          Text('Yesterday',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              )),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: GateManColors.primaryColor,
                  style: BorderStyle.solid,
                  width: .7,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Mr. Seun Adeniyi",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: GateManColors.blackColor,
                  ),
                ),
                subtitle: Text(
                  "Designation - Cook",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                trailing: //Add Button
                    Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: GateManColors.blueColor,
                  ),
                  height: 32.0,
                  width: 70.0,
                  child: Text('Evening',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                ),
              )),
          SizedBox(height: 30.0),
          ActionButton(
            buttonText: 'Add Visitor',
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        icon: MdiIcons.account,
        title: 'Visitors',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
      ),
    );
  }
}
