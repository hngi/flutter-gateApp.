import 'package:flutter/material.dart';
import 'package:gateapp/core/models/user.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/utils/colors.dart';


class AddLocationPermission extends StatefulWidget {
  static final String routeName = '/add_location_permisiion';

AddLocationPermission();
  @override
  _AddLocationPermissionState createState() => _AddLocationPermissionState();
}


class _AddLocationPermissionState extends State<AddLocationPermission> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
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
                onPressed: () {
                  // if (await PermissionsService().hasLocationPermission()==true){
                      Navigator.pushReplacementNamed(
                    context, '/user-type');
                  // } else{
                  //   if (await PermissionsService().requestLocationPermission() == true){
                  //     Navigator.pushReplacementNamed(
                  //   context, '/select-estate');
                  // }
                  //   }

                  },
              )
          ),
        ],
      ),
    ),
  );

  }
}
