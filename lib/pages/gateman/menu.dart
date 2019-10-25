
import 'package:flutter/material.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/residents.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/Loader/loader.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String imageLocation = 'assets/images/gateman/VectorHome.png';
  bool badge = false;

  //int _counter12 = 2;
  LoadingDialog loadingBar;
  List<ResidentUser> _listOfRequests = [];

  @override
  void initState() {
    super.initState();
    loadingBar = LoadingDialog(context, LoadingDialogType.Normal);
    initApp();
  }

  initApp() async {
    setState(() {
      badge = true;
    });
    Future.wait([
      GateManService.getAllRequests(authToken: await authToken(context))
    ]).then((requests) {
      print(requests);
      setState(() {
        _listOfRequests = requests[0];
        badge = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery.of(context).size.width / 100;
    Size size = MediaQuery.of(context).size;

    int numberOfRequests = 0;
    ProfileModel profileModel = setMenuModel(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4F4F4F),
          elevation: 0,
          leading: Container(),
        ),
        body: badge ? Loader.show()
            : ListView(
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
                    icon: Icon(MdiIcons.logout,
                        color: GateManColors.primaryColor),
                    label: Text("Logout",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878787))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/user-type');
                    },
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
              title: Text(profileModel.name?? 'Loading..',
                  style: TextStyle(
                    color: GateManColors.primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  )),
              subtitle: Text("Gateman",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            SizedBox(height: 15.0),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/gateman-notifications');
              },
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
                        child: Text(
                          '${_listOfRequests.length}',
                          style: TextStyle(fontSize: 11.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/residents-gate');
              },
              leading: Image.asset('assets/images/gateman/resi.png'),
              title: Text("Residents",
                  style: TextStyle(
                    color: Color(0xff878787),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/qrReader');
              },
              leading: Image.asset('assets/images/gateman/qrCodeGreen.png'),
              title: Text("Scan QR code",
                  style: TextStyle(
                    color: Color(0xff878787),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
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
        bottomNavigationBar: CustomBottomAppBar(
          alertText: '${_listOfRequests.length}',
          onTapLocation: '/visitors-list',
          nameOfLocation: 'Home',
          imageLocation: imageLocation,
        ) //CustomBottomAppBar(),
    );
  }
}
