import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Privacy Policy'),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 15.0, 10.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Privacy and\nTerms of Service',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 8.0, 0.0),
                    child: FirstParagraph(18.0),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: MyBullet(),
                        title: Text(
                          'We only collect personal data that\'s essential for GateGuard'
                              ' functionality - like your name and phone number, for example.',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      ),
                      ListTile(
                        leading: MyBullet(),
                        title: Text(
                          'We collect aggregated and anonymous data on how people use GateGuard'
                              ' in order to improve the app.',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      ),
                      ListTile(
                        leading: MyBullet(),
                        title: Text(
                          'We own GateGuard, but everything you put in it is 100% your own.'
                              ' We\'ll never share it with 3rd parties without your express permission.',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 8.0, 10.0),
                    child: RichText(textAlign: TextAlign.justify,
                        text: TextSpan(
                            children: [
                              new TextSpan(
                                text: 'We\'re also 100% GDPR-compliant so you can always request'
                                    ' to see your data, where we store it and how it\'s '
                                    'safeguarded as well as delete it all entirely at any point. '
                                    'You can also opt in or out of any emails from us right from '
                                    'your',
                                style: TextStyle(color: Colors.black, fontSize: 18.0),
                              ),
                              new TextSpan(
                                text: ' GateGuard ',
                                style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                text: 'Settings.',
                                style: TextStyle(color: Colors.black, fontSize: 18.0),
                              )
                            ]
                        )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FirstParagraph extends StatelessWidget {
  double fontSize;

  FirstParagraph(this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: [
            new TextSpan(
              text: 'You can always read our ',
              style: TextStyle(color: Colors.black, fontSize: fontSize),
            ),
            new TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green[500],
                  fontSize: fontSize),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch(
                      'https://gateguard.co/termsandconditions.html');
                },
            ),
            
            new TextSpan(
              text:
              ' in full, but we know you\'re busy so here are the highlights:',
              style: TextStyle(color: Colors.black, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

