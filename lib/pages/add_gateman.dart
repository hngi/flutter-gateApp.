import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/dialogs.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';

class AddGateman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Gateman',
            style: TextStyle(
              fontSize: 22.0,
              color: GateManColors.primaryColor,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.28),
                child: Text('You do not have any gateman\n added to your list',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: GateManColors.grayColor,
                        fontWeight: FontWeight.w600)),
              ),
              ActionButton(
                buttonText: 'Add Gateman',
                onPressed: () {


                  Navigator.pushNamed(context, '/add-gateman-detail');
                  // GateManDialogs.successAlert(
                  //   context: context,
                  //   title: 'Confirmed',
                  //   autoDissmiss: true,
                  //   barrierDissmissible: true,
                  //   navToNewScreen: false,
                  // );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
