import 'package:flutter/material.dart';

class Button extends StatelessWidget {
   final Function func;
   final String text;
   final double textSize;
   final double radius;
   final Color color;
   final double width;
   final FontWeight weight;
  
   Button({this.func, this.text, this.textSize, this.radius = 4.0, this.color, this.width, this.weight = FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,
      child: FlatButton(
        onPressed: func,
        child: Text(text, style: TextStyle(fontWeight: weight),),
        color: color,
        textColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}