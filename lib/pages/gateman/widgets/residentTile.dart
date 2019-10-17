import 'package:flutter/material.dart';

import '../scheduledVisit.dart';

class ResidentTile extends StatefulWidget {
  final String name, address, phone, nameV, phoneV, descriptionV, etaV, verificationV, visitStatus;
  final int numberVisit;
  ResidentTile({this.name, this.address, this.phone, this.nameV, this.phoneV, this.descriptionV, this.etaV, this.numberVisit, this.verificationV, this.visitStatus});
  @override
  _ResidentTileState createState() => _ResidentTileState();
}

class _ResidentTileState extends State<ResidentTile> {
  bool details = false;
  void toggle(){
    setState(() {
     details = !details; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(0.0), margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4))),
            child: Column(
              children: <Widget>[
                ListTile(onTap: toggle,
                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name, style: TextStyle(fontSize: 14.0,)),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0, bottom: 4.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.location_on, size: 14.0, color: Color(0xff4F4F4F),),
                          Text(widget.address, style: TextStyle(fontSize: 11.0,))
                        ],),
                      )
                    ],
                  ),
                  subtitle: Row(children: <Widget>[
                        Icon(Icons.phone, size: 14.0, color: Color(0xff4F4F4F)),
                        Text(widget.phone, style: TextStyle(fontSize: 11.0,))
                      ],),
                  trailing: InkWell(onTap: (){Navigator.pushReplacementNamed(context, '/visitors-list');},
                    child: Column(
                      children: <Widget>[
                        Container(padding: const EdgeInsets.only(top:4.0, bottom: 4.0, left: 10.0, right: 10.0), margin: const EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0), color: Color(0xffFFDA58)),
                          child: Text('Scheduled Visit', style: TextStyle(color: Color(0xff4F4F4F), fontSize: 9.0, fontWeight: FontWeight.bold),),
                        ),
                        Container(padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.green),
                          child: Text(widget.numberVisit.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                  ScheduledVisit(
                    name: widget.nameV,
                    phone: widget.phoneV,
                    description: widget.descriptionV,
                    eta: widget.etaV,
                    verification: widget.verificationV,
                    visitStatus: widget.visitStatus,
                  )));/*Navigator.of(context).push(MaterialPageRoute(builder: (context) => new ScheduledVisit(name: widget.name)));*/
                  },
                  child: details ? Padding(
                    padding: const EdgeInsets.only(left:20.0, bottom: 20.0, right: 20.0),
                    child: 
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:8.0, right: 8.0),
                          child: Divider(),
                        ),
                        Column(children: <Widget>[
              Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                      Text('Visitor Info', style: TextStyle(color: Color(0xff464646).withOpacity(0.6), fontSize: 16.0, fontWeight: FontWeight.w600),),
                      Text(widget.visitStatus, style: TextStyle(color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.w700)),
                    ],),
              ),
              Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                      Text('Name:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                      Text(widget.nameV, style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                    ],),
              ),
              Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                      Text('Phone Number:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                      Text(widget.phoneV, style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                    ],),
              ),
              Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                      Text('Description:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                      Text(widget.descriptionV, style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                    ],),
              ),
              Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                      Text('ETA:', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                      Text(widget.etaV, style: TextStyle(color: Color(0xff979797), fontSize: 14.0, fontWeight: FontWeight.w600)),
                    ],),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                    Text('Verified With :', style: TextStyle(color: Color(0xff464646), fontSize: 14.0, fontWeight: FontWeight.w600)),
                    Text(widget.verificationV, style: TextStyle(color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.w700)),
              ],),
              
            ],),
                      ],
                    ),
                  )
                  : Container(),
                ),
              ],
            ),
          );
  }
}