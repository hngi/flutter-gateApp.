import 'package:flutter/material.dart';
import 'package:gateapp/main.dart';
import 'package:gateapp/pages/about.dart';
import 'package:gateapp/utils/helpers.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'FAQ'),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 20.0),
        child: ListView(
          children: <Widget>[
            TopicItem('Frequently Asked Questions'),
            FaqMenuItem('How to add a Gateman', Icons.keyboard_arrow_down),
            FaqMenuItem('How to schedule visits', Icons.keyboard_arrow_down),
            FaqMenuItem('Turn on notifications', Icons.keyboard_arrow_down),
            FaqMenuItem('SMS/Phone call scheduling', Icons.keyboard_arrow_down),
            Container(
                padding: EdgeInsets.only(top: 130.0),
                child: TopicItem('Have More Questions?')),
            FaqMenuItem('Support', Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class FaqMenuItem extends StatelessWidget {
  String text;

  IconData icon;

  FaqMenuItem(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(bottom: 15.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          //top: BorderSide(color: Colors.grey[300]),
            bottom: BorderSide(color: Colors.grey[300])),
      ),
      child: ListTile(
        //contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        title: Center(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                icon,
                size: 40.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class TopicItem extends StatelessWidget {
  String text;

  TopicItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey[300])),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
