import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  
  final String text;
  final bool checked;
  
  CustomCheckBox({@required this.text,this.checked=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/rectangle.png'),
          SizedBox(width: 10,),
          Text(text,style: TextStyle(fontSize: 12,color: Color(0xFF4F4F4F)),)
        ],
      ),
    );
  }
}
