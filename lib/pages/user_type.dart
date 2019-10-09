import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/utils/colors.dart';


class UserType extends StatefulWidget {
  @override
  _UserType createState() => _UserType();
}

class _UserType extends State<UserType> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            child: Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: Text(
                'How do you intend to use\n\t\t\t\t\t\t\t\t\t\t\t\t\t GatePass?',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
        GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.85,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Card(
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: GateManColors.primaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Layer.png'),
                  )
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Resident',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),

                    ),

                  ),
                ),
              ),
            ),

           Card(
              elevation: 2.0,

              child: Container(
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/OfficerAsset.png'),
                  )
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'GateMan',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                      ),

                    ),

                  ),
                ),
              ),
            ),


          ],
        ),

          SizedBox(height: 15.0),
          Align(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Text(
                'Sign in as a resident to enjoy unlimited \t\t\t\t\t\t\t\t\t\t\t\t\taccess in managing your visitor',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey
                ),
              ),
            ),
          ),


          Container(
              padding: EdgeInsets.all(20.0),
              child: ActionButton(
                buttonText: 'Continue',
                onPressed: () {},
              )
          ),
        ],
      ),
    );

  }

}
