import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/GateManExpansionTile/gateman_expansion_tile.dart';

class ManageGateman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Manage Gateman'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: 30.0),
          GateManExpansionTile(
            fullName: 'Idris Abdulkareem',
            phoneNumber: '0812345678',
            dutyTime: 'Morning',
          ),
          GateManExpansionTile(
            fullName: 'Vector Tha Viper',
            phoneNumber: '0812345678',
            dutyTime: 'Evening',
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(34.0),
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: GateManColors.primaryColor,
            ),
            height: 50.0,
            width: 50.0,
            child: Icon(Icons.add, color: Colors.white, size: 30.0),
          ),
        ],
      ),
    );
  }
}
