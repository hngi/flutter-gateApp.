import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class RoundedAlertBox extends StatefulWidget {
  @override
  _RoundedAlertBoxState createState() => _RoundedAlertBoxState();
}

class _RoundedAlertBoxState extends State<RoundedAlertBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: openAlertBox,
        child: Text(
          "Open Alert Box",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: GateManColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:10.0,bottom: 5),
                          child: Image.asset('assets/images/success.png'),
                        ),
                        
                        Text('Visitor added successfully',style: TextStyle(fontSize: 20),),
                        SizedBox(
                          height: 5.0,
                        ),
                        
                      ],
                    ),
                  ),

                  Divider(
                    color: Colors.white,
                    height: 2.0,
                  ),

                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Text('Send Invitation',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF466446)),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Visitor : ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color(0xFF4f4f4f)),),
                              Text('Mr Seun Adeniyi',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color(0xFF4f4f4f)),),
                            ],
                          ),
                        ),
                        
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Image.asset('assets/images/qr.png'),
                        ),

                        Text('Show this at the security gate',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color(0xFF49A347)),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
}
