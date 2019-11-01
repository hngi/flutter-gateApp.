import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/faq.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/BottomMenu/bottom_menu.dart';
import 'package:http/http.dart' as http;

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

String faq_txt =
    'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.';
Future<Faq> fetchFaq() async {
  final response = await http.get('http://gateappapi.herokuapp.com/api/v1/faq');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Faq.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'FAQ'),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          FutureBuilder(
              future: fetchFaq(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return new Text('Input a URL to start');
                  case ConnectionState.waiting:
                    return new Center(child: new Text('FAQ Loading ...', style: TextStyle(fontSize: 20.0, color: Colors.grey.withOpacity(0.5)),));
                  case ConnectionState.active:
                    return new Text('');
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return new Text(
                        '${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return //Text(snapshot.data.faqs.length.toString());//Text(snapshot.data.faqs[1].title.toString());
                          ListView.builder(
                            shrinkWrap: true, physics: ScrollPhysics(),
                        itemCount: snapshot.data.faqs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return //Text(snapshot.data.faqs[index].title.toString());
                              FaqMenuItem(
                                  snapshot.data.faqs[index].title.toString(),
                                  snapshot.data.faqs[index].content.toString());
                        },
                      );
                    }
                }
              }),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: TopicItem('Have More Questions?')),
            BottomMenu(
                'Support',
                    () => Navigator.pushNamed(context, '/support'),
                Border(bottom: BorderSide(color: Colors.grey[300]))),
        ],
        
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
        border: Border(bottom: BorderSide(color: Colors.grey[300])),
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
        subtitle: isVisible ? 
        Padding(
          child: Text(widget.desc), padding: const EdgeInsets.all(13.0),
        )
         : null,
        trailing: isVisible
            ? Icon(Icons.keyboard_arrow_up, size: 25.0, color: Colors.grey)
            : Icon(Icons.keyboard_arrow_down),
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
