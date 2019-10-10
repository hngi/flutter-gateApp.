import 'package:flutter/material.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditProfile extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _phoneNumber, _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Edit Profile'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: .8,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/woman-cooking.png',
                        fit: BoxFit.contain,
                        height: 85.0,
                        width: 85.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(Icons.add_a_photo,
                        color: Colors.white, size: 23.0),
                  ),
                ],
              ),
            ),

            SizedBox(height: 23.0),

            //Name
            CustomTextFormField(
              labelName: 'Name',
              onSaved: (str) => _name = str,
              validator: (str) => str.isEmpty ? 'Name cannot be empty' : null,
              initialValue: 'Danny John',
            ),

            //Phone
            CustomTextFormField(
              labelName: 'Phone',
              onSaved: (str) => _phoneNumber = str,
              validator: (str) => str.isEmpty ? 'Phone cannot be empty' : null,
              initialValue: '0812345678',
            ),

            //Email
            CustomTextFormField(
              labelName: 'Email',
              onSaved: (str) => _email = str,
              validator: (str) => str.isEmpty ? 'Email cannot be empty' : null,
            ),

            SizedBox(height: 40.0),

            ActionButton(
              buttonText: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
