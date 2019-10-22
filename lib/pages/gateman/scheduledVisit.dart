import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScheduledVisit extends StatefulWidget {
  final String name, phone, description, eta, verification, visitStatus;

  ScheduledVisit(
      {this.name,
      this.phone,
      this.description,
      this.eta,
      this.verification,
      this.visitStatus});

  @override
  _ScheduledVisitState createState() => _ScheduledVisitState();
}

class _ScheduledVisitState extends State<ScheduledVisit> {
  bool badge = true;
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    final wv = MediaQuery.of(context).size.width / 100;
    final hv = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Visit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.dotsVertical),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 18.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Visitor Info',
                        style: TextStyle(
                            color: Color(0xff464646).withOpacity(0.6),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(widget.visitStatus,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Name:',
                          style: TextStyle(
                              color: Color(0xff464646),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                      Text(widget.name,
                          style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Phone Number:',
                          style: TextStyle(
                              color: Color(0xff464646),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                      Text(widget.phone,
                          style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Description:',
                          style: TextStyle(
                              color: Color(0xff464646),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                      Text(widget.description,
                          style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('ETA:',
                          style: TextStyle(
                              color: Color(0xff464646),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                      Text(widget.eta,
                          style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Verified With :',
                        style: TextStyle(
                            color: Color(0xff464646),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600)),
                    Text(widget.verification,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
