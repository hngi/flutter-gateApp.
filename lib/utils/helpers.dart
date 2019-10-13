import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/IncomingVisitorListTile/incoming_visitor_list_tile.dart';

class GateManHelpers {
  GateManHelpers._(); //this helps to instantiate the class

  static Widget bigText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 42.0,
        fontWeight: FontWeight.w700,
        color: GateManColors.primaryColor,
      ),
    );
  }

  // This is used to calculate the size of component based on the current height of the screen
  static double screenAwareSize(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.height;
  }

  static double screenAwareWidth(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.width;
  }

  static openAlertBox(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 0.0),
            titlePadding: EdgeInsets.only(top: 0),

            content: Container(
              //width: 300.0,
              child: Container(
                color: GateManColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: GateManColors.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 15.0, bottom: 5),
                            child: Image.asset('assets/images/success.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Text(
                              'Visitor added successfully',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Send Invitation',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF466446)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Visitor : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4f4f4f)),
                                ),
                                Text(
                                  'Mr Seun Adeniyi',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF4f4f4f)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Image.asset(
                              'assets/images/qr.png',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: RaisedButton(
                              color: Color(0xFFffa700),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                height: 50.0,
                                alignment: Alignment.center,
                                child: Text(
                                  '4561WT',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Show this at the security gate',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF49A347)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16,horizontal: 16
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: GateManColors.primaryColor)),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/share.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF49A347)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //default app bar
  static AppBar appBar(BuildContext context, String title) {
    return AppBar(
    
      title: Text(title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
          color: Colors.white,
        ),
      ],
    );
  }

  //borders around the text fields
  static final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide(
      color: GateManColors.primaryColor,
      style: BorderStyle.solid,
      width: 1.0,
    ),
  );

  //Visiting time color
  static Color getVisitingTimeColor(VisitingTime time) {
    switch (time) {
      case VisitingTime.morning:
        return GateManColors.yellowColor;
        break;
      case VisitingTime.afternoon:
        return GateManColors.primaryColor;
        break;
      case VisitingTime.evening:
        return GateManColors.blueColor;
        break;
      default:
        return GateManColors.yellowColor;
        break;
    }
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(0.0),
      height: 15.0,
      width: 15.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
