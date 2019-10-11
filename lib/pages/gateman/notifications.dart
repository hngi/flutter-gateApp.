import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/invitationTile.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/pages/gateman/residents.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu.dart';

class GatemanNotifications extends StatefulWidget {
  final name;
  GatemanNotifications({this.name});
  @override
  _GatemanNotificationsState createState() => _GatemanNotificationsState();
}

class _GatemanNotificationsState extends State<GatemanNotifications> {
  bool badge = true;
  int _counter = 1;
  var _notifications = [
    {
      "name": "Janet Thompson",
      "address": "Block 3A, Dele Adebayo Estate",
      "phone": 08038000000,
    },
    {
      "name": "Mark Evans",
      "address": "UB junction, Molyko Estate",
      "phone": 07865412876,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final wv = MediaQuery.of(context).size.width/100;
    final hv = MediaQuery.of(context).size.width/100;
    return Scaffold(
      appBar: AppBar(title: Text('Notifications'), actions: <Widget>[IconButton(icon: Icon(MdiIcons.dotsVertical),onPressed: (){},)],),
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
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index){
          return InvitationTile(
            rname: _notifications[index]['name'],
            raddress: _notifications[index]['address'],
            rphone: _notifications[index]['phone'],
            func: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Residents(name: widget.name,)));},);
        },
      ),
    );
  }
}

