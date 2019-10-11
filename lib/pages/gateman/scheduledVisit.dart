import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/notifications.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/pages/gateman/residents.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu.dart';

class ScheduledVisit extends StatefulWidget {
  final name;
  ScheduledVisit({this.name});
  @override
  _ScheduledVisitState createState() => _ScheduledVisitState();
}

class _ScheduledVisitState extends State<ScheduledVisit> {
  bool badge = true;
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    final wv = MediaQuery.of(context).size.width/100;
    final hv = MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: AppBar(title: Text('Scheduled Visit'), actions: <Widget>[IconButton(icon: Icon(MdiIcons.dotsVertical),onPressed: (){},)],),
     bottomNavigationBar: new BottomAppBar(
        color: GateManColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top:15.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: SizedBox(height: hv*14,
            child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Menu(name: widget.name,)));},
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/gateman/menu.png'),
                    Text('Menu', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ),)
                  ],
                ),
              ),
              InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => new GatemanNotifications(name: widget.name,)));},
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/images/gateman/notification.png'),
                        badge ? Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6),),
                            constraints: BoxConstraints(minWidth: 12,minHeight: 12,),
                            child: new Text('$_counter',style: new TextStyle(color: Colors.white,fontSize: 8,),textAlign: TextAlign.center,),
                          ),
                          ):Container()
                      ],
                    ),
                    Text('Alert', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ))
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(width: 110.0, height:110.0,
      child:   new FloatingActionButton(backgroundColor: GateManColors.primaryColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset('assets/images/gateman/residents.png'),
              ),
              Text('Residents', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),)
              ],
  
              ), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Residents(name: widget.name,)));},
  
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        children: <Widget>[
          Container(padding: const EdgeInsets.all(20.0), margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 18.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4))),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Text('Visitor Info', style: TextStyle(color: Color(0xff464646).withOpacity(0.6), fontSize: 16.0, fontWeight: FontWeight.w600),),
                  Text('Approved', style: TextStyle(color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.w700)),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Text('Name:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                  Text('John Doe', style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Text('Phone Number:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                  Text('09099886625', style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Text('Description:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                  Text('Bald, Tall and ...', style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                  Text('ETA:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                  Text('00:00 - 00:00', style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                ],),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                Text('Verified With :', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                Text('QR CODE', style: TextStyle(color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.w700)),
              ],),
              
            ],),
          ),
        ],
      ),
    );
  }
}