import 'package:flutter/material.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/BottomMenu/bottom_menu.dart';

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
                'How to add a Gateman', faq_txt),
            FaqMenuItem(
                'How to schedule visits', faq_txt),
            FaqMenuItem(
                'Turn on notifications', faq_txt),
            FaqMenuItem('SMS/Phone call scheduling', faq_txt),
            Container(
                padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                child: TopicItem('Have More Questions?')),
            BottomMenu(
                'Support', () {}, Border(bottom: BorderSide(color: Colors.grey[300]))),
          ],
        ),
      ),
    );
  }
}

class FaqMenuItem extends StatefulWidget {
  FaqMenuItem(this.text, this.desc);

  final String text, desc;

  @override
  _FAQMenuState createState() => _FAQMenuState();
}

// ignore: must_be_immutable
class _FAQMenuState extends State<FaqMenuItem> {

  bool isVisible = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(bottom: 15.0),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(color: Colors.grey[300])),
      ),
      child: ListTile(
        title: Center(
          child: Row(
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
        trailing: isVisible ? Icon(Icons.keyboard_arrow_up, size: 25.0, color: Colors.grey) :
        Icon(Icons.keyboard_arrow_down),
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