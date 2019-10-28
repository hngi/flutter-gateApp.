import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';

class CustomCheckBox extends StatelessWidget {
  
  final String text;
  final bool checked;
  
  CustomCheckBox({@required this.text,this.checked=false});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            width: 14,
            height: 14,
            child: Container(color: this.checked?GateManColors.primaryColor:Colors.white,),
            decoration: BoxDecoration(color: Colors.white,
            border: Border.all(color: GateManColors.primaryColor)),
          ),
          SizedBox(width: 10,),
          Text(text,style: TextStyle(fontSize: 12,color: Color(0xFF4F4F4F)),)
        ],
      );
    
  }
}
