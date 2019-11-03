import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/notification/resident_notification_model.dart';
import 'package:xgateapp/pages/gateman/widgets/residents_notification.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationResident extends StatefulWidget {
  final String name;
  NotificationResident({this.name});
  @override
  _NotificationResidentState createState() => _NotificationResidentState();
}

class _NotificationResidentState extends State<NotificationResident> {

 

  @override
  Widget build(BuildContext context) {
    // appIsConnected().then((isConnected){
    //   if (isConnected == true){
    //     if(getResidentNotificationProvider(context).loadedFromApi == false && getResidentNotificationProvider(context).loading != true){
      
    //   loadResidentNotificationFromApi(context);
    // }
    //   }

    // });
    
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Notifications'),
      body:RefreshIndicator(child:ListView(
        
        children:buildNotificationBody() == null || buildNotificationBody().isEmpty?<Widget>[Container(
          width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/2,
          child: Center(child: Text('No Notification Available',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)))]:buildNotificationBody()
        ), 
        onRefresh: (){
          return loadResidentNotificationFromApi(context);
        }
        ,),

    
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: MdiIcons.account,
        title: 'Visitors',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          print("leading clicked");
          Navigator.pushReplacementNamed(context, '/homepage');
        },
        onTrailingClicked: () {},
      ),
    );
  }
  

  List<Widget> buildNotificationBody(){
    List<Widget> bodyView = [];
    if(getResidentNotificationProvider(context).forVisitorModels != null && getResidentNotificationProvider(context).forVisitorModels.length > 0){
        bodyView.add(

          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 20.0),
                child: Text(
                  'Visitors',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 160.0),
                child: Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
            ],
          )

        );

      bodyView.add( Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: ListView.builder(
                    itemCount: getResidentNotificationProvider(context).forVisitorModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ResidentsNotificationList(
                          name: getResidentNotificationProvider(context).forVisitorModels[index].notificationData['body'],
                          time: getResidentNotificationProvider(context).forVisitorModels[index].createdAt.toString()??'',
                          notificationId: getResidentNotificationProvider(context).forVisitorModels[index].id,
                          model: getResidentNotificationProvider(context).forVisitorModels[index],
                          
                        ),
                      );
                    
                    },
                  ),
                ),
              ),
            ],
          )

);
    }
if(getResidentNotificationProvider(context).forInviteModels!= null && getResidentNotificationProvider(context).forInviteModels.length > 0){
        bodyView.add(

          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 20.0),
                child: Text(
                  'Invites',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 160.0),
                child: Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
            ],
          )

        );

      bodyView.add(Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: ListView.builder(
                    itemCount: getResidentNotificationProvider(context).forInviteModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ResidentsNotificationList(
                          name: getResidentNotificationProvider(context).forInviteModels[index].notificationData['body']??'',
                          time: getResidentNotificationProvider(context).forInviteModels[index].createdAt.toString()??'',
                          notificationId: getResidentNotificationProvider(context).forInviteModels[index].id??'',
                          model: getResidentNotificationProvider(context).forInviteModels[index],
                          
                        ),
                      );
                    
                    },
                  ),
                ),
              ),
            ],
          )
          );
    }
    return bodyView;

  }
  

  
}