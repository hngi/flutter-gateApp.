import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xgateapp/pages/estate_payment/estate_payments.dart';
import 'package:xgateapp/pages/homepage.dart';
import 'package:xgateapp/pages/visitors.dart';
import 'package:xgateapp/pages/welcome_resident.dart';
import 'package:xgateapp/utils/colors.dart';

class ResidentMainPage extends StatefulWidget {
  @override
  _ResidentMainPageState createState() => _ResidentMainPageState();
}

class _ResidentMainPageState extends State<ResidentMainPage> {
  int _currentIndex = 0;
  static final List<Widget> _children =  [
       WelcomeResident(),
    MyVisitors(),
      EstatePayments(),
    Homepage()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: GateManColors.primaryColor,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: GateManColors.grayColor)),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('My Visitors'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text('Payments'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              title: Text('More'),
            )
          ],
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );

  }
}
