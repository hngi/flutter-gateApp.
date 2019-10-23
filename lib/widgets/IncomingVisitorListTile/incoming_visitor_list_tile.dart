import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

enum VisitingTime { morning, afternoon, evening }

class IncomingVisitorListTile extends StatelessWidget {
  final String fullName;
  final String estateName;
  final String time;
  final VisitingTime visitingTime;

  const IncomingVisitorListTile({
    Key key,
    @required this.fullName,
    @required this.estateName,
    @required this.time,
    @required this.visitingTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey, width: .5),
      ),
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FittedBox(
            child: Container(
              width: 7.0,
              height: 68.0,
              decoration: BoxDecoration(
                  color: GateManHelpers.getVisitingTimeColor(visitingTime),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                  )),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: GateManColors.blackColor,
                      ),
                    ),
                  ),
                  Text(
                    estateName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //time
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
