import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class Register extends StatelessWidget {
  String _fullName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.13),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GateManHelpers.bigText('Register'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 26.0),
            child: Text(
                'Welcome to a peaceful a safe way to manage your visitors',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.grayColor)),
          ),

          //Full Name
          CustomTextFormField(
            labelName: 'Full Name',
            onSaved: (str) => _fullName = str,
            validator: (str) =>
                str.isEmpty ? 'Full Name cannot be empty' : null,
            initialValue: 'Mr. B',
          ),

          SizedBox(height: 40.0),

          ActionButton(
            buttonText: 'Join',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
