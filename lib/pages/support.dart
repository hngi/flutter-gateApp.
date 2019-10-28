import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  TextEditingController _emailController;
  TextEditingController _subjectController;
  TextEditingController _msgController;

  String _email;
  String _subject;
  String _msg;


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: GateManHelpers.appBar(context, 'Support'),
        body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[

          CustomTextFormField(
            controller: _emailController,
            labelName: 'Email',
            onSaved: (str) => _email = str,
            validator: (str) =>
                str.isEmpty ? 'Email cannot be empty' : null,
          ),

          CustomTextFormField(
            controller: _subjectController,
            labelName: 'Subject',
            onSaved: (str) => _subject = str,
            validator: (str) =>
                str.isEmpty ? 'Subject cannot be empty' : null,
          ),

          CustomTextFormField(
            maxLines: 4,
            controller: _msgController,
            labelName: 'Issues',
            onSaved: (str) => _msg = str,
            validator: (str) =>
                str.isEmpty ? 'Message cannot be empty' : null,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 26.0),
            child: Text(
                'Please describe the issue with as much details as possible to enable our support staff get a clear picture and offer solutions to the problem',
                style: TextStyle(
                    fontSize: 12.0,
                    color: GateManColors.grayColor)),
          ),

          SizedBox(height: 40.0),
          ActionButton(
            buttonText: 'SAVE',
            onPressed: (){},
          )
        ]));
    }
              
}
