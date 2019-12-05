import 'package:flutter/material.dart';
import 'package:xgateapp/pages/gateman/notifications.dart';
import 'package:xgateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:xgateapp/pages/gateman/widgets/customFab.dart';
import 'package:xgateapp/pages/gateman/widgets/listTileMenu.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'residents.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name = 'Danny Evans';
  bool badge = true;
  int _counter = 2;
  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery.of(context).size.width / 100;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4F4F4F),
        elevation: 0,
        leading: Container(),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text("Help",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff878787))),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Icon(MdiIcons.helpCircleOutline,
                            color: GateManColors.primaryColor),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),

                //Logout
                FlatButton.icon(
                  icon:
                      Icon(MdiIcons.logout, color: GateManColors.primaryColor),
                  label: Text("Logout",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff878787))),
                  onPressed: () {Navigator.pushNamed(context, '/user-type');},
                ),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 70.0,
              height: 100.0,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Positioned(
                    left: 9.0,
                    child: Container(
                      height: 60.0,
                      width: 57.0,
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
            title: Text(name,
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                )),
            subtitle: Text("Security Guard",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(height: 15.0),
          ListTile(
            onTap: () {Navigator.pushNamed(context, '/gateman-notifications');},
            leading: Image.asset('assets/images/gateman/alert.png'),
            title: Row(
              children: <Widget>[
                Text("Alerts",
                    style: TextStyle(
                      color: Color(0xff878787),
                      fontSize: 14.0,
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text('1',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {Navigator.pushNamed(context, '/residents-gate');},
            leading: Image.asset('assets/images/gateman/resi.png'),
            title: Text("Residents",
                style: TextStyle(
                  color: Color(0xff878787),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                )),
          ),
          ListTile(
            onTap: () {Navigator.pushNamed(context, '/qrReader');},
            leading: Image.asset('assets/images/gateman/qrCodeGreen.png'),
            title: Text("Scan QR code",
                style: TextStyle(
                  color: Color(0xff878787),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                )),
          ),
          ListTile(
            onTap: () {Navigator.pushNamed(context, '/settings');},
            leading: Image.asset('assets/images/gateman/settings.png'),
            title: Text("Settings",
                style: TextStyle(
                  color: Color(0xff878787),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ),

      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar()

      // bottomNavigationBar: new BottomAppBar(
      //   color: GateManColors.primaryColor,
      //   child: Padding(
      //     padding: const EdgeInsets.only(top:15.0, left: 20.0, right: 20.0, bottom: 10.0),
      //     child: SizedBox(height: hv*14,
      //       child: new Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Menu(name: widget.name,)));},
      //           child: Column(
      //             children: <Widget>[
      //               Image.asset('assets/images/gateman/menu.png'),
      //               Text('Menu', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ),)
      //             ],
      //           ),
      //         ),
      //         InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => new GatemanNotifications(name: widget.name,)));},
      //           child: Column(
      //             children: <Widget>[
      //               Stack(
      //                 children: <Widget>[
      //                   Image.asset('assets/images/gateman/notification.png'),
      //                   badge ? Positioned(
      //                     right: 0,
      //                     child: new Container(
      //                       padding: EdgeInsets.all(1),
      //                       decoration: new BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6),),
      //                       constraints: BoxConstraints(minWidth: 12,minHeight: 12,),
      //                       child: new Text('$_counter',style: new TextStyle(color: Colors.white,fontSize: 8,),textAlign: TextAlign.center,),
      //                     ),
      //                     ):Container()
      //                 ],
      //               ),
      //               Text('Alert', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ))
      //             ],
      //           ),
      //         ),
      //       ],
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButton: SizedBox(width: 110.0, height:110.0,
      // child:   new FloatingActionButton(backgroundColor: GateManColors.primaryColor,
      //   child: Column(mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.only(bottom: 4.0),
      //           child: Image.asset('assets/images/gateman/residents.png'),
      //         ),
      //         Text('Residents', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),)
      //         ],

      //         ), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Residents(name: widget.name,)));},

      //         ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
