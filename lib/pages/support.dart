import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:dio/dio.dart';

import 'gateman/widgets/customDialog.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final _supportKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();
  TextEditingController _msgController = new TextEditingController();

  String _email;
  String _subject;
  String _msg;
  String email;
  String subject;
  String issues;
  bool buttonState = true;

  Future send() async {
    final form = _supportKey.currentState;
    if (form.validate()) {
      setState(() {
        buttonState = false;
      });
      Dio dio = new Dio();
      Response response;
      try {
        response = await dio.post("${Endpoint.baseUrl}support/send",
            data: {"subject": subject, "email": email, "message": issues});
        print(response.data['message'].toString());
        if (response.data['message'].toString() ==
            "Thanks for contacting us!") {
          setState(() {
            buttonState = true;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                title: "",
                description: "Your request have been successfully received",
                buttonText: "okay",
                func: () {
                  // Navigator.pushNamed(context, '/residents-gate');
                  Navigator.pop(context);
                }),
          );
          setState(() {
            _emailController.text = "";
            _subjectController.text = "";
            _msgController.text = "";
          });

          print("yeah");
        } else if (response.data['message'].toString() !=
            "Thanks for contacting us!") {
          setState(() {
            buttonState = true;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                title: "",
                description: "Sorry, couldn't send request",
                buttonText: "okay",
                func: () {
                  // Navigator.pushNamed(context, '/residents-gate');
                  Navigator.pop(context);
                }),
          );
        } else {
          setState(() {
            buttonState = true;
          });
          print("failed");
        }
      } catch (e) {
        print(e);
      }

      print("valid form: $email $subject $issues");
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: GateManHelpers.appBar(context, 'Support'),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          children: <Widget>[
            Form(
              key: _supportKey,
              child: Column(children: <Widget>[
                CustomTextFormField(
                  onChanged: (s) => setState(() => email = s),
                  controller: _emailController,
                  labelName: 'Email',
                  onSaved: (str) => _email = str,
                  validator: (str) =>
                      !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(str)
                          ? "Enter Valid Email address"
                          : null,
                ),
                CustomTextFormField(
                    onChanged: (s) => setState(() => subject = s),
                    controller: _subjectController,
                    keyboardType: TextInputType.emailAddress,
                    labelName: 'Subject',
                    onSaved: (str) => _subject = str,
                    validator: (str) {
                      str.isEmpty ? 'Subject cannot be empty' : null;
                    }),
                CustomTextFormField(
                  onChanged: (s) => setState(() => issues = s),
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
                          fontSize: 12.0, color: GateManColors.grayColor)),
                ),
                SizedBox(height: 40.0),
                buttonState
                    ? ActionButton(
                        buttonText: 'SAVE',
                        onPressed: () {
                          send();
                        },
                      )
                    : CircularProgressIndicator()
              ]),
            ),
          ],
        ));
  }
}
