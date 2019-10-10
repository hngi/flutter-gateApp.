import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class IncomgVisitorsWithDesignation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text('Welcome Mr. Danny',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text('Peace Estate',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text('Incoming Visitors',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                )),
          ),
          Text('Today',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              )),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: GateManColors.primaryColor,
                  style: BorderStyle.solid,
                  width: .7,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  "Mr. Seun Adeniyi",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: GateManColors.blackColor,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
