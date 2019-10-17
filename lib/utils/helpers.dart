import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/errors.dart';
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

  static ErrorType getErrorType(Map<String, dynamic> errorRes) {
    print(errorRes);
    if (errorRes.containsKey('email')) return ErrorType.email_taken;
    if (errorRes.containsKey('password')) return ErrorType.password_dont_match;
    if (errorRes.containsKey('phone')) return ErrorType.phone;
    if (errorRes.containsKey('verifycode'))
      return ErrorType.verify_code_atleast_5_chars;

    return ErrorType.generic;

    //verify_code_not_found
  }
  
  static Map<ErrorType,String> errorTypeMap = {
    ErrorType.email_taken : 'Email has been used',
    ErrorType.phone : 'Phone Error',
    ErrorType.verify_code_not_found: 'Wrong Verification Code'

};
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
