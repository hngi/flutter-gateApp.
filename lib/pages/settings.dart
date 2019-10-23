import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';

import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/BottomMenu/bottom_menu.dart';

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

bool inAppNotificationOn = false;
bool pushNotificationOn = false;
bool locationOn = false;

class _SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        () => Navigator.pushNamed(context, '/manage-address'),
                        Border(bottom: BorderSide.none)),
                  ),
                ],
              )),

//          Notification & Tracking

          Container(
            padding: EdgeInsets.only(top: 20.0, left: 30.0),
            child: Text(
              'Nofications & Tracking',
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

                    //Gesture Detector

                    child: _NotifAndTracking(
                          text:'In-app Notification',
                          decoration:Border(bottom: BorderSide(color: Colors.grey[300])),
                          isSwitched:inAppNotificationOn, onChanged: (bool isSwitched) {
                     setState(() {
                       inAppNotificationOn = isSwitched;
                     });
                          },),
                  ),
                  Container(
                      child: _NotifAndTracking(
                          text:'Push Notification',
                          decoration:Border(bottom: BorderSide(color: Colors.grey[300])),
                          isSwitched:pushNotificationOn, onChanged: (bool isSwitched) {
                            setState(() {
                            pushNotificationOn = isSwitched;
                            
                          });}),),
                  Container(
                    child: _NotifAndTracking(text:'Location Tracking',
                        decoration:Border(bottom: BorderSide.none), isSwitched:locationOn,onChanged:(bool isSwitched){
                          
                          setState(() {
                             locationOn = isSwitched;
                          });
                         
                        }),
                  ),
                ],
              )),

//           Help & Support

          Container(
            padding: EdgeInsets.only(top: 20.0, left: 30.0),
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
                        'About GatePass',
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
                        'Support', () {}, Border(bottom: BorderSide.none)),
                  ),
                ],
              )),

//          Logout button

          Container(
              child: ActionButton(
            buttonText: 'Logout',
            onPressed: () {},
          )),
        ],
      ),
    );
  }
}

class _NotifAndTracking extends StatelessWidget {
  String text;
  Function _setState;
  Border decoration;
  bool isSwitched = false;
  Function(bool) onChanged;
  // bool notificationOn = true;

  // void _onchanged(bool value) {
  //   _setState(() {
  //     isSwitched = value;
  //   });
  // }

  _NotifAndTracking({this.text, this.decoration, this.isSwitched,@required this.onChanged});

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
              this.onChanged(value);  
            },
            
            activeTrackColor: Colors.green,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}