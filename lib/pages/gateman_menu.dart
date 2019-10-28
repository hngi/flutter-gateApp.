import 'package:flutter/material.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GateManMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(MdiIcons.accountQuestionOutline,
                      color: GateManColors.primaryColor),
                  label: Text("Help",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: GateManColors.grayColor)),
                  onPressed: () {},
                ),

                //Logout
                FlatButton.icon(
                  icon:
                      Icon(MdiIcons.logout, color: GateManColors.primaryColor),
                  label: Text("Logout",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: GateManColors.grayColor)),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          //User Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 80.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Positioned(
                      right: 25.0,
                      child: Container(
                        height: 68.0,
                        width: 67.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: GateManColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      // left: 3.0,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/gateman/Ellipse.png'),
                        maxRadius: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(gateManProvider?.gatemanUser?.fullName ?? '',
                          style: TextStyle(
                            color: GateManColors.primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Text("GateMan",
                        style: TextStyle(
                          color: GateManColors.grayColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 23.0),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/gateman-notifications');
            },
            leading: Icon(MdiIcons.newspaper,
                color: GateManColors.primaryColor, size: 25.0),
            title: Row(
              children: <Widget>[
                Text("Alerts",
                    style: TextStyle(
                      color: GateManColors.grayColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 16.0,
                    width: 16.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text('1',
                        style: TextStyle(fontSize: 13.0, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/residents');
            },
            leading: Icon(MdiIcons.accountGroup,
                color: GateManColors.primaryColor, size: 25.0),
            title: Text("Residents",
                style: TextStyle(
                  color: GateManColors.grayColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/scan-qr');
            },
            leading: Icon(MdiIcons.qrcode,
                color: GateManColors.primaryColor, size: 25.0),
            title: Text("Scan QR Code",
                style: TextStyle(
                  color: GateManColors.grayColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),

          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
            leading: Icon(MdiIcons.settings,
                color: GateManColors.primaryColor, size: 25.0),
            title: Text("Settings",
                style: TextStyle(
                  color: GateManColors.grayColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/residents');
        },
        icon: MdiIcons.accountGroup,
        title: 'Residents',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.home,
        leadingText: 'Home',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {},
        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
