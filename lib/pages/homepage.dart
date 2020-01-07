import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/pages/gateman/widgets/residents_notification.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'estate_payment/estate_payments.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int notifications = getResidentNotificationProvider(context).getTotalNumberOfUnreadNotifications;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: <Widget>[
          // SizedBox(height: size.height * 0.05),
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
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
                  onPressed: () {
                    Navigator.pushNamed(context,'/support');
                  },
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
                                      //  Positioned(
                                      //   right: 25.0,
                                      //   child: Container(
                                      //     height: 68.0,
                                      //     width: 67.0,
                                      //     alignment: Alignment.center,
                                      //     decoration: BoxDecoration(
                                      //       color: GateManColors.primaryColor,
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //   ),
                                      // ),
                                      Positioned(
                                        // left: 3.0,
                                        
                                        child: ClipOval(
                                                                                  child: CircleAvatar(
                                            radius: 32,
                                            child:
                                            getProfileProvider(context).profileModel.image!='noimage.jpg' &&
                                            getProfileProvider(context).profileModel.image!=null
                                            ?
                                            FadeInImage.assetNetwork(image: Endpoint.imageBaseUrl+ '${getProfileProvider(context).profileModel.image}',
                                            placeholder:'assets/images/gateman_white.png',):
                                                Image.asset('assets/images/avatar.png'),
                                            
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
                                      InkWell(
                                        onTap: (){
                                          if (getProfileProvider(context).profileModel.homeModel ==null || getProfileProvider(context).profileModel.homeModel.houseBlock ==null
                                          || (getProfileProvider(context).profileModel.homeModel !=null && getProfileProvider(context).profileModel.homeModel.houseBlock !=null &&
                                          getProfileProvider(context).profileModel.homeModel.houseBlock.isEmpty)){
                                            Navigator.pushNamed(context,'/manage-address');
                                          } else{
                                            Navigator.pushNamed(context,'/manage-address',arguments: getProfileProvider(context).profileModel.homeModel.houseBlock);
                                          }

                                        },
                                        child: Text(getProfileProvider(context).profileModel.homeModel !=null && getProfileProvider(context).profileModel.homeModel.houseBlock !=null?getProfileProvider(context).profileModel.homeModel.houseBlock:'set address',
                                        
                                            style: TextStyle(
                                              fontStyle: getProfileProvider(context).profileModel.homeModel?.houseBlock !=null?null:FontStyle.italic,
                                              color: GateManColors.grayColor,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
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
                                    child: notifications==null || notifications==0?Container(width: 0,height: 0,):Container(
                                      height: 16.0,
                                      width: 16.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(notifications.toString(),
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
                              title: Text("Manage Security Guard",
                                  style: TextStyle(
                                    color: GateManColors.grayColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  onTap: (){Navigator.pushNamed(context, '/manage-gateman');
                                  },
                            ),
                            ListTile(
                              leading: Icon(MdiIcons.accountMultiple,
                                  color: GateManColors.primaryColor, size: 25.0),
                              title: Text("My Visitors",
                                  style: TextStyle(
                                    color: GateManColors.grayColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                                  onTap: (){Navigator.pushNamed(context, '/my-visitors');
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
                              onTap: () {
                                Navigator
                                .of(context)
                                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                                return new EstatePayments();
                                }));
                                // Navigator.pushNamed(context, '/estate_payments');
                              },
                              leading: Icon(MdiIcons.creditCard,
                                  color: GateManColors.primaryColor, size: 25.0),
                              title: Text("Estate Payments",
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
                      );
                    }
}
                  
                   



