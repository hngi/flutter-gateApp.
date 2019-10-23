import 'package:flutter/material.dart';

import 'button.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final Function func;

  CustomDialog({
    this.title,
    @required this.description,
    @required this.buttonText,
    this.image, this.func
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
    
  }
  dialogContent(BuildContext context) {
   return Container(
    margin: EdgeInsets.only(bottom: 100.0), padding: EdgeInsets.only(bottom: 20.0),
    decoration: new BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: const Offset(0.0, 10.0),
      ),
    ],
  ),
   child: Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 22.0),
        Image.asset('assets/images/gateman/ok.png'),
        SizedBox(height: 20.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff494949)
          ),
        ),
       SizedBox(height: 14.0),
       Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(color: Colors.green, text: buttonText, func: func, weight: FontWeight.w600,),
          ),
        ),
      ],
    ),
  );
  }
}

