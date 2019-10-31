import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:xgateapp/widgets/VisitorsTiles/visitorsTile.dart';


class MyVisitors extends StatefulWidget {
  @override
  _MyVisitorsState createState() => _MyVisitorsState();
}

List _visitors = [
    {
      "name":"James Cameron",
      "relation":"Friend",
      "phone":"0812567898",
      "date":"2nd Nov 2019",
      "avatarLink":"assets/images/avatar2.jpg"
    },
    {
      "name":"Mr. Seun Adeyini",
      "relation":"Father",
      "phone":"0486332555",
      "date":"1st Dec 2019",
      "avatarLink":"assets/images/avatar2.jpg"
    },
    {
      "name":"Mrs. Angelina Taffo",
      "relation":"Wife",
      "phone":"6987533255",
      "date":"3th august 2020",
      "avatarLink":"assets/images/avatar2.jpg"
    },
  ];

class _MyVisitorsState extends State<MyVisitors> {

    final Map<int, Widget> children = <int, Widget>{
    0: Padding(child:Text('Scheduled', style: TextStyle(color: scheduledColor),), padding: EdgeInsets.all(10.0),),
    1: Padding(child:Text('Saved', style: TextStyle(color: savedColor)), padding: EdgeInsets.all(10.0),),
    2: Padding(child:Text('History', style: TextStyle(color: historyColor)), padding: EdgeInsets.all(10.0),),
  };
  
  static Color scheduledColor = Colors.grey;
  static Color savedColor = Colors.grey;
  static Color historyColor = Colors.grey;

  final Map<int, Widget> icons = <int, Widget>{
    0: Center(
      child: scheduledTab,
    ),
    1: Center(
      child: savedTab,
    ),
    2: Center(
      child: historyTab,
    ),
  };

  int sharedValue = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Visitors'),
      floatingActionButton: BottomNavFAB(
                   onPressed: () {
                     Navigator.pushNamed(context, '/add_visitor');
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
                     Navigator.pushNamed(context, '/homepage');
                   },
                   onTrailingClicked: () {
                     Navigator.pushNamed(context, '/resident-notifications');
                   },
                 ),
        body: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: CupertinoPageScaffold(
      child: DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 500.0,
                  child: CupertinoSegmentedControl<int>(
                    children: children,
                    onValueChanged: (int newValue) {
                      setState(() {
                        sharedValue = newValue;
                        /*if(newValue == 0){
                        setState(() {
                         scheduledColor = Colors.green; 
                         savedColor = Colors.grey; 
                         historyColor = Colors.grey; 
                        });
                      }else if(newValue == 1){
                        setState(() {
                         scheduledColor = Colors.grey; 
                         savedColor = Colors.green; 
                         historyColor = Colors.grey; 
                        });
                      } else {
                        setState(() {
                         scheduledColor = Colors.grey; 
                         savedColor = Colors.grey; 
                         historyColor = Colors.green; 
                        });
                      }*/
                      });
                      
                      print('$newValue');
                      
                    },
                    groupValue: sharedValue,
                    borderColor: Colors.grey.withOpacity(0.2),
                    selectedColor: Colors.grey.withOpacity(0.2),
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                       
                      horizontal: 12.0,
                    ),
                    child: Container(
                      child: icons[sharedValue],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    ),
        ),
    );
  }
}

Widget scheduledTab = ListView.builder(
                      
        itemCount: _visitors.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: VisitorTile(
                      name: _visitors[index]['name'],
                      phone: _visitors[index]['phone'],
                      relation: _visitors[index]['relation'],
                      date: _visitors[index]['date'],
                      timeline: "Expected Arrival",
                      buttonText1: "Edit",
                      buttonText2: "Remove",
                      buttonFunc1: (){},
                      avatarLink: _visitors[index]['avatarLink'],
                      buttonFunc2: (){
                        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to remove visitor ?'),
            content: Text('Visitor will no longer be in your scheduled liste.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {Navigator.pop(context);},
                  child: Text('Cancel')),
              FlatButton(
                onPressed: () {},
                child: Text('Remove'),
              )
            ],
          );
        });
                      },
                      ),
          );
        },

      );

Widget savedTab = ListView.builder(
                      
        itemCount: _visitors.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: VisitorTile(
                      name: _visitors[index]['name'],
                      phone: _visitors[index]['phone'],
                      relation: _visitors[index]['relation'],
                      date: _visitors[index]['date'],
                      timeline: "Last Visit",
                      buttonText1: "Remove",
                      buttonText2: "Schedule Visit",
                      buttonFunc1: (){},
                      buttonFunc2: (){
                        showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to remove visitor ?'),
            content: Text('Visitor will no longer be in your scheduled liste.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {Navigator.pop(context);},
                  child: Text('Cancel')),
              FlatButton(
                onPressed: () {},
                child: Text('Remove'),
              )
            ],
          );
        });
                      },
                      avatarLink: _visitors[index]['avatarLink'],
                      ),
          );
        },
      );

Widget historyTab = ListView(children: <Widget>[
  VisitorTile(avatarLink: 'assets/images/gateman/Ellipse.png', name: 'James Cameron', relation: 'Friend', timeline: 'Expected Arrival', phone: '65165151651', date: '2nd Nov 2019, Afternoon', buttonText1: 'Edit', buttonText2: 'Remove', buttonFunc1: (){}, buttonFunc2: (){},),
  VisitorTile(avatarLink: 'assets/images/gateman/Ellipse.png', name: 'James Cameron', relation: 'Friend', timeline: 'Expected Arrival', phone: '65165151651', date: '2nd Nov 2019, Afternoon', buttonText1: 'Edit', buttonText2: 'Remove', buttonFunc1: (){}, buttonFunc2: (){},),
  VisitorTile(avatarLink: 'assets/images/gateman/Ellipse.png', name: 'James Cameron', relation: 'Friend', timeline: 'Expected Arrival', phone: '65165151651', date: '2nd Nov 2019, Afternoon', buttonText1: 'Edit', buttonText2: 'Remove', buttonFunc1: (){}, buttonFunc2: (){},),

],);