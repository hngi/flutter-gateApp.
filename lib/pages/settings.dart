import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';

import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/BottomMenu/bottom_menu.dart';


class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

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
                    child: BottomMenu('Edit Profile', () {},
                        Border(bottom: BorderSide(color: Colors.grey[300]))),

                  ),
                  Container(
                    child: BottomMenu('Manage Address', () => Navigator.pushNamed(context, '/manage-address'),
                        Border(bottom: BorderSide.none)),
                  ),
                ],
              )
          ),

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
                    child: _NotifAndTracking('In-app Notification', () {},
                        Border(bottom: BorderSide(color: Colors.grey[300])), true),

                  ),
                  Container(
                      child: _NotifAndTracking('Push Notification', () {},
                          Border(bottom: BorderSide(color: Colors.grey[300])), true)
                  ),

                  Container(
                    child: _NotifAndTracking('Location Tracking', () {},
                        Border(bottom: BorderSide.none), false),
                  ),
                ],
              )
          ),

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
                    child: BottomMenu('About GatePass', () => Navigator.pushReplacementNamed(context, '/about'),
                        Border(bottom: BorderSide(color: Colors.grey[300]))),

                  ),
                  Container(
                    child: BottomMenu('Frequently Asked Questions', () => Navigator.pushNamed(context, '/faq'),
                        Border(bottom: BorderSide(color: Colors.grey[300]))),
                  ),
                  Container(
                    child: BottomMenu('Privacy Policy', () => Navigator.pushNamed(context, '/privacy-policy'),
                        Border(bottom: BorderSide(color: Colors.grey[300]))),
                  ),
                  Container(
                    child: BottomMenu('Support', () {},
                        Border(bottom: BorderSide.none)),),
                ],
              )
          ),

//          Logout button

          Container(
              child: ActionButton(
                buttonText: 'Logout',
                onPressed: () {},
              )
          ),


        ],
      ),

    );
  }
}

class _NotifAndTracking extends StatelessWidget {
  String text;
  Function onTap;
  Border decoration;
  bool isSwitched;

  _NotifAndTracking(this.text, this.onTap, this.decoration, this.isSwitched);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      splashColor: Colors.green[500],
      child: Container(
        decoration: BoxDecoration(
          border: decoration,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child:
              Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
//                setState(() {
//                  isSwitched = value;
//                });
              },
              activeTrackColor: Colors.green,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}