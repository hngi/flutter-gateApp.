import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class CustomBottomAppBar extends StatelessWidget {

  final Widget leadingIcon;
  final String leadingText;
  final Widget trailingIcon;
  final String trailingText;
  final Function leadingFunc;
  final Function trailingFunc;
  final String alertText;

  CustomBottomAppBar({this.leadingText, this.leadingIcon, this.leadingFunc, this.trailingText, this.trailingIcon, this.trailingFunc, this.alertText});

  @override
  Widget build(BuildContext context) {
    final hv = MediaQuery.of(context).size.width / 100;
    return BottomAppBar(
        color: GateManColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top:15.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: SizedBox(height: hv*14,
            child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(onTap: (){Navigator.pushReplacementNamed(context, '/menu');},
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/gateman/menu.png'),
                    Text('Menu', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ),)
                  ],
                ),
              ),
              
              InkWell(onTap: (){Navigator.pushReplacementNamed(context, '/gateman-notifications');},
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset('assets/images/gateman/notification.png'),
                        Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6),),
                            constraints: BoxConstraints(minWidth: 12,minHeight: 12,),
                            child: new Text(alertText,style: new TextStyle(color: Colors.white,fontSize: 8,),textAlign: TextAlign.center,),
                          ),
                          )
                      ],
                    ),
                    Text('Alert', style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold ))
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      );
  }
}
