import 'package:flutter/material.dart';
import 'package:gateapp/core/endpoints/endpoints.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                        child: Text(getProfileProvider(context).profileModel?.name == null ? 'Name' : getProfileProvider(context).profileModel?.name.toString() ?? 'Name',
                                            style: TextStyle(
                                              color: GateManColors.primaryColor,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ),
                                      Text(getProfileProvider(context).profileModel.homeModel?.houseBlock !=null?getProfileProvider(context).profileModel.homeModel.houseBlock:'not set',
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
                              onTap: (){Navigator.pushNamed(context, '/resident-notifications');},
                            ),
                            ListTile(
                              leading: Icon(MdiIcons.watch,
                                  color: GateManColors.primaryColor, size: 25.0),
                              title: Text("Manage Gateman",
                                  style: TextStyle(
                                    color: GateManColors.grayColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  onTap: (){Navigator.pushNamed(context, '/manage-gateman');
                                  },
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/service_directory_resident');
                              },
                              leading: Icon(MdiIcons.hammer,
                                  color: GateManColors.primaryColor, size: 25.0),
                              title: Text("Service Directory",
                                  style: TextStyle(
                                    color: GateManColors.grayColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                  
                            ListTile(
                              leading: Icon(MdiIcons.settings,
                                  color: GateManColors.primaryColor, size: 25.0),
                              title: Text("Settings",
                                  style: TextStyle(
                                    color: GateManColors.grayColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  onTap: (){Navigator.pushNamed(context, '/resident-settings');},
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
                          leadingIcon: MdiIcons.home,
                          leadingText: 'Home',
                          traillingIcon: MdiIcons.bell,
                          traillingText: 'Alerts',
                          onLeadingClicked: () {
                            Navigator.pop(context);
                          },
                          onTrailingClicked: () {
                            Navigator.pushReplacementNamed(context, '/resident-notifications');
                          },
                        ),
                      );
                    }
}
                  
                   



