import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

class VisitorsBox extends StatelessWidget {

  final String visitorsName,visitorsNumber;

  VisitorsBox({@required this.visitorsName,@required this.visitorsNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 80,width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: GateManColors.textColor,
        )
      ),

      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(visitorsName,style: TextStyle(fontSize: 14,color: Color(0xFF494949),fontWeight: FontWeight.w600),),
                Icon(Icons.keyboard_arrow_down,color: Colors.green,)
              ],
            ),
            Text(visitorsNumber,style: TextStyle(fontSize: 10,color: Color(0xFF878787)),)
          ],
        ),
      ),
    );
  }
}
