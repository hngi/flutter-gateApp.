import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/notification/resident_notification_model.dart';
import 'package:xgateapp/core/service/notification_service/resident_notification_service.dart';
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
  List<ResidentNotificationModel> total= [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      markAllAsRead();
    });
  }


 

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
      body:RefreshIndicator(child:Container(
        child: buildNotificationBody() == null || buildNotificationBody().isEmpty?
        Container(
          width:MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height/2,
          child: ListView(children: [
            Center(child:
            Padding(
              child: Column(

              children: <Widget>[ Image.asset(
                'assets/images/no_notification_icon.png',scale: 2,
              ),
                Text('You do not have any notification',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ],
            ), 
            padding: EdgeInsets.only(
              top:MediaQuery.of(context).size.height/4
            ),))]
            )
        )
        :
        Column(
          children:buildNotificationBody()
        ),
      )
      
      , 
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
    if(getResidentNotificationProvider(context).forInviteModels != null) total.addAll(getResidentNotificationProvider(context).forInviteModels);
    if(getResidentNotificationProvider(context).forVisitorModels != null) total.addAll(getResidentNotificationProvider(context).forVisitorModels);
    if(total != null && total.length > 0){
        
      bodyView.addAll( <Widget>[
                Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 20.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0,right:20.0),
                child: InkWell(
                  onTap: ()async{
                   markAllAsRead();
                   
                                     },
                                        child: Text(
                                       'Mark all as read',
                                       style: TextStyle(
                                         fontSize: 14.0,
                                         color: GateManColors.textColor,
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             )
                   
                           ,
                                 Expanded(
                                   child: SizedBox(
                                     height: 130.0,
                                     child: ListView.builder(
                                       itemCount: total.length,
                                       itemBuilder: (BuildContext context, int index) {
                                         return Padding(
                                           padding: const EdgeInsets.only(bottom: 15.0),
                                           child: ResidentsNotificationList(
                                             name: total[index].notificationData['body'],
                                             time: total[index].createdAt.toString()??'',
                                             notificationId: total[index].id,
                                             model: total[index],
                                             
                                           ),
                                         );
                                       
                                       },
                                     ),
                                   ),
                                 ),
                               ],
                             );
                       }
                   
                       return bodyView;
                   
                     }
                   
                     void markAllAsRead() async{
                        dynamic response = await ResidentNotificationService.markselectedNotificationAsRead(
                      notificationIds: total.where((ResidentNotificationModel test){
                        return test.read == false;
                    }).map((ResidentNotificationModel model){
                      return model.id;
                    }).toList()
                    ) ;
                    print(response);

                    loadResidentNotificationFromApi(context);
                     }
  

  
}