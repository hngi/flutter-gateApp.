import 'package:flutter/material.dart';
import 'package:gateapp/utils/helpers.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

String faq_txt =
    'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.';

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'FAQ'),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
        child: ListView(
          children: <Widget>[
            TopicItem('Frequently Asked Questions'),
            FaqMenuItem(
                'How to add a Gateman', Icons.keyboard_arrow_down, faq_txt),
            FaqMenuItem(
                'How to schedule visits', Icons.keyboard_arrow_down, faq_txt),
            FaqMenuItem(
                'Turn on notifications', Icons.keyboard_arrow_down, faq_txt),
            FaqMenuItem('SMS/Phone call scheduling', Icons.keyboard_arrow_down,
                faq_txt),
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                child: TopicItem('Have More Questions?')),
            FaqMenuItem('Support', Icons.keyboard_arrow_right, faq_txt),
          ],
        ),
      ),
    );
  }
}

class FaqMenuItem extends StatefulWidget {
  FaqMenuItem(this.text, this.icon, this.desc);

  final String text, desc;
  final IconData icon;

  @override
  _FAQMenuState createState() => _FAQMenuState();
}

// ignore: must_be_immutable
class _FAQMenuState extends State<FaqMenuItem> {
  //String text, desc;

  //IconData icon;
  bool isVisible = false;

  //FaqMenuItem(this.text, this.icon, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(bottom: 15.0),

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
                widget.text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        subtitle: isVisible ? Text(widget.desc) : null,
        //isThreeLine: true,
        trailing: Icon(widget.icon, size: 25.0, color: Colors.grey),
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
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
        border: Border(bottom: BorderSide(color: Colors.grey[300])),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
