import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/core/models/user.dart';
import 'package:provider/provider.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: TypeOfUser());
  }

}

class TypeOfUser extends StatefulWidget {
  @override
  _TypeOfUser createState() => _TypeOfUser();
}

class _TypeOfUser extends State<TypeOfUser> {


  user_type type = user_type.RESIDENT;

  void _setUserType(user_type type){
    setState((){
      this.type = type;
    });
  }
  @override
  Widget build(BuildContext context) {
    UserTypeProvider userTypeProvider = Provider.of<UserTypeProvider>(context, listen:false);
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
                'How do you intend to use\n\t\t\t\t\t\t\t\t\t\t\t GatePass?',
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
            GestureDetector(
              onTap: (){
                print('resident tapped');
                this._setUserType(user_type.RESIDENT);
                userTypeProvider.setUserType(user_type.RESIDENT);},
              child: Card(
                elevation: this.type==user_type.RESIDENT?5.0:1.0,
                child: Container(
                  height:this.type==user_type.RESIDENT?450.0:300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: GateManColors.primaryColor,
                    image: DecorationImage(
                      image:AssetImage('assets/images/Layer.png'),
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
            ),

           GestureDetector(
             onTap: (){
               print("Gateman Tapped");
               this._setUserType(user_type.GATEMAN);
               userTypeProvider.setUserType(user_type.GATEMAN);},
             child: Card(
                elevation: this.type==user_type.RESIDENT?1.0:5.0,

                child: Container(
                  height: this.type==user_type.RESIDENT?300.0:450.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          color: GateManColors.primaryColor,
                        ),

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
                'Sign in as a resident to enjoy unlimited access in \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t managing your visitor',
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
                onPressed: () => Navigator.pushReplacementNamed(context, '/add-location',arguments: this.type),
              )
          ),
        ],
      ),
    );

  }

}

