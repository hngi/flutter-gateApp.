import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GateManMenu extends StatefulWidget {
  @override
  _GateManMenuState createState() => _GateManMenuState();
}

class _GateManMenuState extends State<GateManMenu> {
  int _alerts = 0;
  bool loaded = false;

  @override
  void initState(){
    super.initState();
    initApp();
  }

  initApp() async{
    setState(() {
      loaded = false;
    });

    Future.wait([
      GatemanService.allRequests(authToken: await authToken(context)),
    ]).then((alerts){
      print(alerts);
      _alerts = alerts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    appIsConnected().then((bool isConn){
      if (isConn && !getUserTypeProvider(context).loggeOut){
        if(!getProfileProvider(context).loadedFromApi){
                loadInitialProfile(context);
              }
              
        if(!getRequestProvider(context).isLoadedFromApi){
          loadInitRequests(context);
        }
      }
    });
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
                  onPressed: ()=>logOut(context),
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
                      child: ClipOval(
                                      child: CircleAvatar(
                                      radius: 32,
                                      child:
                                      getProfileProvider(context).profileModel.image!='no_image'||
                                      getProfileProvider(context).profileModel.image!=null
                                      ?
                                      FadeInImage.assetNetwork(image: Endpoint.imageBaseUrl+ '${getProfileProvider(context).profileModel.image}',
                                      placeholder:'assets/images/gateman_white.png',):
                                          AssetImage('assets/images/gateman_white.png'),
                                      
                                          ),
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
                      child: Text(getProfileProvider(context).profileModel?.name?? 'Loading. . .',
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
                    child: Text(_alerts.toString(),
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
        alerts: _alerts.toString(),
        onLeadingClicked: () {},

        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
