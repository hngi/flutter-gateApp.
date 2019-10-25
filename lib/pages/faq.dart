import 'package:flutter/material.dart';
import 'package:gateapp/core/service/faq_service.dart';
import 'package:gateapp/providers/faq_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/constants.dart' as prefix0;
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/BottomMenu/bottom_menu.dart';
import 'package:gateapp/core/service/faq_service.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

String faq_txt =
    'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.';

class _FAQState extends State<FAQ> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'FAQ'),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          children: getAllFaq(context),
        ),
      ),
    );
  }

  getAllFaq(BuildContext context) {
    bool isVisible = false;

    List<Widget> faqs = <Widget>[
//        SizedBox(height: size.height * 0.06),
      TopicItem('Frequently Asked Questions'),

      Container(
          padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
          child: TopicItem('Have More Questions?')),
      BottomMenu(
          'Support',
              () => Navigator.pushNamed(context, '/support'),
          Border(bottom: BorderSide(color: Colors.grey[300]))),


    ];

    faqs.addAll(getFAQProvider(context).faqModel.map((faqModel){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Colors.grey[300])),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,

              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      faqModel.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              subtitle: isVisible ? Text(faqModel.content) : null,
              trailing: isVisible ? Icon(Icons.keyboard_arrow_up, size: 25.0, color: Colors.grey) :
              Icon(Icons.keyboard_arrow_down),
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },

            ),
          )
        ],
      );
    }).toList());

    return faqs;
  }

  void loadFAQ(BuildContext context) async {
    try {
      dynamic response = await FAQService.getFAQ();
      print('getting FAQ');
      print(response);

      if(response is ErrorType) {
        PaysmosmoAlert.showError( context: context, message: GateManHelpers.errorTypeMap(response));
        if(response == ErrorType.no_faq_found){
          getFAQProvider(context).setInitialStatus(true);
          PaysmosmoAlert.showSuccess(context: context, message: GateManHelpers.errorTypeMap(response));
        }
      } else {
          if (response['faqs'].length == 0) {
            PaysmosmoAlert.showSuccess(
                context: context, message: 'No FAQ yet');
          } else {
            print('loading FAQ');
            print(response['faqs']);
            dynamic jsonFAQModels = response['visitor'];
            List<FAQModel> models = [];
            jsonFAQModels.forEach((jsonModel) {
              models.add(FAQModel.fromJson(jsonModel));
            });
            getFAQProvider(context).setFAQModels(models);


          }
        }
      } catch (error) {
      print(error);
      throw error;
    }
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