import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:xgateapp/core/streams/settings_stream.dart';
import 'package:xgateapp/providers/faqBloc.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';

import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/BottomMenu/bottom_menu.dart';

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  
   Future<bool> _togglePushNotifications({@required BuildContext context,bool newVal})async{
     LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
     dialog.show();
     print(newVal);
     bool result;
    if (!newVal){
      bool value = await setFCMTokenToEmpty(context);
      Navigator.pop(context);
        if(!value){
          result =  false;
       
        }else {
          print('switched off');
        NotificationStream.pushNotificationController.sink.add(false);
        }
        
 
    }
    else{
      bool onValue = await setFCMTokenInServer(context);
      Navigator.pop(context);
         if(!onValue){
           result =  false;
         } else{
           print('switched on');
         NotificationStream.pushNotificationController.sink.add(true);
         }
         
       
    }
       if(result == null){
         result = true;
       }
       
       return result;
    
    
  
}
  @override
  Widget build(BuildContext context) {
    // print(getProfileProvider(context).profileModel.homeModel.houseBlock);
    return ChangeNotifierProvider<FaqBloc>.value(
      value: FaqBloc(),
      child: Scaffold(
        appBar: GateManHelpers.appBar(context, 'Setting'),
        body: ListView(
          children: <Widget>[
//          Account

            Container(
              padding: EdgeInsets.only(top: 20.0, left: 30.0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 16.0,
                  color: GateManColors.textColor,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300]),
                      bottom: BorderSide(color: Colors.grey[300])),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: BottomMenu(
                          'Edit Profile',
                          () => Navigator.pushNamed(context, '/edit-profile'),
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                    ),
                    Container(
                      child: BottomMenu(
                          'Manage Address',
                          () => Navigator.pushNamed(context, '/manage-address',
                              arguments: getProfileProvider(context).profileModel.homeModel == null
                              ? ''
                                  : getProfileProvider(context)
                                      .profileModel
                                      .homeModel
                                      .houseBlock),
                          Border(bottom: BorderSide.none)),
                    ),
                  ],
                )),

//          Notification & Tracking

            Container(
              padding: EdgeInsets.only(top: 20.0, left: 30.0),
              child: Text(
                'Notifications & Tracking',
                style: TextStyle(
                  fontSize: 16.0,
                  color: GateManColors.textColor,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300]),
                      bottom: BorderSide(color: Colors.grey[300])),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: StreamBuilder<Object>(
                        stream: NotificationStream.inAppNotificationController.stream,
                        builder: (context, snapshot) {
                          return _NotifAndTracking(
                              'In-app Notification',
                              Border(bottom: BorderSide(color: Colors.grey[300])),
                              snapshot.data??true,switchButton: (bool switchedState){

                              },
                              );
                        }
                      ),
                    ),
                    Container(
                        child: StreamBuilder<Object>(
                          stream: NotificationStream.pushNotificationController.stream,
                          builder: (context, snapshot) {
                            return _NotifAndTracking(
                                'Push Notification',
                                Border(bottom: BorderSide(color: Colors.grey[300])),
                                snapshot.data??true, switchButton: (bool nV)async{return _togglePushNotifications(context: context,newVal: nV);},);
                          }
                        )),
                        Container(
                      child: StreamBuilder<Object>(
                        stream: LocationStream.locationSwitchController.stream,
                        builder: (context, snapshot) {
                           return _NotifAndTracking('Location Tracking',
                              Border(bottom: BorderSide.none), snapshot.data??true,switchButton: (bool switchedState){
                              });
                                                }
                      ),
                    ),
                  ],
                )),

//           Help & Support

            Container(
              child: Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 16.0,
                  color: GateManColors.textColor,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300]),
                      bottom: BorderSide(color: Colors.grey[300])),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: BottomMenu(
                          'About GateGuard',
                          () => Navigator.pushReplacementNamed(context, '/about'),
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                    ),
                    Container(
                      child: BottomMenu(
                          'Frequently Asked Questions',
                          () => Navigator.pushNamed(context, '/faq'),
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                    ),
                    Container(
                      child: BottomMenu(
                          'Privacy Policy',
                          () => Navigator.pushNamed(context, '/privacy-policy'),
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                    ),
                    Container(
                      child: BottomMenu(
                          'Support',
                          () => Navigator.pushNamed(context, '/support'),
                          Border(bottom: BorderSide.none)),
                    ),
                  ],
                )),

//          Logout button

            Container(
                child: ActionButton(
              buttonText: 'Logout',
              onPressed: () {logOut(context);},
            )),
          ],
        ),
      ),
    );
  }
}

class _NotifAndTracking extends StatelessWidget {
  String text;
  Border decoration;
  bool isSwitched = false;
 Function (bool) switchButton;
  void _onchanged(bool value) async{
    bool success = await switchButton(value);
    // if(success)
    // // {_setState(() {
    // //   isSwitched = value;
    // // });
    // }
  }

  _NotifAndTracking(this.text, this.decoration, this.isSwitched,{@required this.switchButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
      decoration: BoxDecoration(
        border: decoration,
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Switch(
            value: isSwitched,
            onChanged: (bool value) {
              _onchanged(value);
            },
            activeTrackColor: Colors.green,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

 
}
