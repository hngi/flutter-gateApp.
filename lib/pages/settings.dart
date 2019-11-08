import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xgateapp/providers/faqBloc.dart';
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
                      child: _NotifAndTracking(
                          'In-app Notification',
                          Border(bottom: BorderSide(color: Colors.grey[300])),
                          true),
                    ),
                    Container(
                        child: _NotifAndTracking(
                            'Push Notification',
                            Border(bottom: BorderSide(color: Colors.grey[300])),
                            true)),
                    Container(
                      child: _NotifAndTracking('Location Tracking',
                          Border(bottom: BorderSide.none), false),
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
  Function _setState;
  Border decoration;
  bool isSwitched = false;

  void _onchanged(bool value) {
    _setState(() {
      isSwitched = value;
    });
  }

  _NotifAndTracking(this.text, this.decoration, this.isSwitched);

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
