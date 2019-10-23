import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/notifications.dart';
import 'package:gateapp/pages/gateman/residents.dart';
import 'package:gateapp/utils/colors.dart';

class GatemanWelcome extends StatefulWidget {
  final fullname;
  GatemanWelcome({this.fullname});
  @override
  _GatemanWelcomeState createState() => _GatemanWelcomeState();
}

class _GatemanWelcomeState extends State<GatemanWelcome> {
  int invitations = 2;
  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
                    padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                    child: Text('Welcome ${widget.fullname}',style: TextStyle(fontSize: 23.0, color: GateManColors.primaryColor, fontWeight: FontWeight.bold))),
          Column(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top: 121.0, bottom: 47.0),
                child: Image.asset('assets/images/gateman/welcome.png'),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have', style: TextStyle(color: Colors.black54, fontSize: 17.0, fontWeight: FontWeight.bold )),
                  InkWell(onTap: (){Navigator.pushReplacementNamed(context, '/gateman-notifications');},
                    child: Text(' $invitations invitations ', style: TextStyle(color: GateManColors.primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ),
                  
                ],
                
              ),
              Text('from residents', style: TextStyle(color: Colors.black54, fontSize: 17.0, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}
