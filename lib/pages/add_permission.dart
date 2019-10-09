import 'package:flutter/material.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/utils/colors.dart';


class AddPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: Location());
  }
}

class Location extends StatefulWidget {
  @override
  _AddPermissionState createState() => _AddPermissionState();
}


class _AddPermissionState extends State<Location> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Spacer(),
        Container(
          height: size.height * 0.4,
          width: double.infinity,
          child: Image.asset('assets/images/addLocationBg.png'),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          height: size.height * 0.4,
          width: double.infinity,

          child: Column(

            children: <Widget>[
              Text(
                'Location permission required',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 50.0),
              Text(
                'Your location permission will be required for easy accessibility ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
//                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
            ],
          ),
        ),


        Container(
          padding: EdgeInsets.all(20.0),
            child: ActionButton(
              buttonText: 'Ok, turn on permission',
              onPressed: () => Navigator.pushReplacementNamed(
                  context, '/select-estate'),
            )
        ),
      ],
    ),
  );

  }
}
