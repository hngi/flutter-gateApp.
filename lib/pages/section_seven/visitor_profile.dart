import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class VisitorProfile extends StatelessWidget {
  final _User visitor = _User(
    name: 'Mr. Ryan Brain',
    phone: '080995653333',
    vehicleNo: 'KJA-657AA',
    purpose: 'Plumbing work',
    eta: '10:40am',
  );
  final _User toSee = _User(
    name: 'Mr. Frank Dan',
    address: 'Plot 4, HNG Street',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Verdana',
        iconTheme: IconThemeData.fallback().copyWith(
          color: Colors.green,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Visitor Profile'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      maxWidth: 100,
                      minHeight: 100,
                      minWidth: 100,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.black54,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    child: Center(
                      child: Text(
                        visitor.name,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.green),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    color: Colors.teal.withOpacity(0.1),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Whom to see',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.contacts,
                                size: 14,
                              ),
                              SizedBox(width: 10),
                              Text(
                                toSee.name,
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                size: 14,
                              ),
                              SizedBox(width: 10),
                              Text(
                                toSee.address,
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: 14,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Phone',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                          Text(
                            visitor.phone,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.directions_car,
                            size: 14,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Vehicle Reg. No.',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                          Text(
                            visitor.vehicleNo,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.textsms,
                            size: 14,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Purpose',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                          Text(
                            visitor.purpose,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.directions_run,
                            size: 14,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'ETA',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                          Text(
                            visitor.eta,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'View more details.',
                              style: TextStyle(color: Colors.green),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_down, color: Colors.green)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _User {
  final String name;
  final String phone;
  final String vehicleNo;
  final String purpose;
  final String eta;
  final String address;

  _User({
    this.name,
    this.phone,
    this.vehicleNo,
    this.purpose,
    this.eta,
    this.address,
  });
}