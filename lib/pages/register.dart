import 'package:flutter/material.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  String _fullName = 'Mr. B';
  @override
  Widget build(BuildContext context) {
    ResidentUserProvider residentUserModelProvider =
        Provider.of<ResidentUserProvider>(context, listen: false);
    UserTypeProvider userTypeProvider =
        Provider.of<UserTypeProvider>(context, listen: false);

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

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
            onChanged: (str) {
              this._fullName = str;
            },
            validator: (str) =>
                str.isEmpty ? 'Full Name cannot be empty' : null,
            initialValue: _fullName,
          ),

          SizedBox(height: 40.0),

          ActionButton(
            buttonText: 'Join',
            onPressed: () {
              if (userTypeProvider.type == user_type.RESIDENT) {
                print("jjjjjjjjjj" + _fullName);
                residentUserModelProvider.setResidentFullName(
                    residentFullName: _fullName);
                Navigator.pushNamed(context, '/welcome-resident');
              } else {
                gateManProvider.setFullName(fullName: _fullName);
                Navigator.pushNamed(context, '/residents');
              }
            },
          ),
        ],
      ),
    );
  }
}
