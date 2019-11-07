import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/widgets/IncomingVisitorListTile/incoming_visitor_list_tile.dart';

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
  static AppBar appBar(BuildContext context, String title,{List<Widget> actions}) {
    return AppBar(
      title: Text(title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      actions: actions
      //  <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.more_vert),
      //     onPressed: () {},
      //     color: Colors.white,
      //   ),
      // ],
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

  static String errorTypeMap(ErrorType errorType) {
    switch (errorType) {
      case ErrorType.email_taken:
        return 'Email has been used';
      case ErrorType.phone:
        return 'Phone Error';
      case ErrorType.verify_code_not_found:
        return 'Wrong Verification Code';
      case ErrorType.network:
        return 'Please make sure your device is connected to the internet';
      case ErrorType.no_visitors_found:
        return 'You are not expecting any Visitor';
      case ErrorType.username_at_least_2_char:
        return 'Name must be at least two characters';
      case ErrorType.no_gateman_found:
        return 'No GateMan Found with this number in your estate';
      case ErrorType.unauthorized:
        return 'Unauthorized';
      case ErrorType.request_already_sent_to_gateman:
        return 'Request already Sent,Please await Confirmation';
      case ErrorType.invalid_input_in_register:
        return 'Invalid Input';
      case ErrorType.server:
        return 'Server Error, Please try again';
      case ErrorType.cannot_check_visitor:
        return 'You do not have the permission to checkout this Visitor';
      case ErrorType.no_visitor_with_code:
        return 'No visitor with such code';
      case ErrorType.visitior_has_not_checked_out: return 'Visitor is yet to be Checked Out';

      default:
        return 'Unknown Error Occurred';
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
