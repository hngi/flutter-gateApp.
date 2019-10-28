import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';

class ResidentInfoCard extends StatelessWidget {
  final String fullName;
  final String address;
  final String phoneNumber;
  final String visitText;
  final String numberCount;

  const ResidentInfoCard({
    Key key,
    @required this.fullName,
    @required this.address,
    @required this.phoneNumber,
    @required this.visitText,
    @required this.numberCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: GateManColors.blackColor,
                  ),
                ),

                //location
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.my_location, color: Colors.black, size: 16.0),
                      SizedBox(width: 6.0),
                      Text(
                        address,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                //phone
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.phone, color: Colors.black, size: 16.0),
                      SizedBox(width: 6.0),
                      Text(
                        phoneNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Add Button
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: GateManColors.yellowColor,
                  ),
                  height: 28.0,
                  width: 95.0,
                  child: Text(visitText,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500)),
                ),

                SizedBox(height: 9.0),

                //Number count
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: GateManColors.primaryColor,
                  ),
                  height: 35.0,
                  width: 40.0,
                  child: Text(numberCount,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
