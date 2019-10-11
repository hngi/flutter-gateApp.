import 'package:flutter/material.dart';
import 'package:gateapp/utils/helpers.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  TextEditingController myTextController = TextEditingController();

  Widget suffix;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'About GatePass'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 50.0,
              height: 50.0,
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/gate_pass.png',
              width: 25.0,
              height: 25.0,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 40.0, 50.0),
            /*height: size.height * 0.4,
                          color: GateManColors.primaryColor,*/
            width: double.infinity,
            child: Text(
              'GatePass is a visitor management system for small to large estates. It\'s a fast'
                  ', convenient and cost-effective answer to access control.\n\n'
                  'With GatePass you can:\n - Verify authenticity of visitors\'s information\n'
                  ' - Track time spent on premises\n - Load and save regular visitors\n - Receive'
                  ' visitor arrival notifications',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Colors.grey[300]),
                    bottom: BorderSide(color: Colors.grey[300])),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: BottomMenu('Tell a Friend', () {},
                        Border(bottom: BorderSide(color: Colors.grey[300]))),

                  ),
                  Container(
                    child: BottomMenu('Rate the App', () => rateGatePass(context),
                        Border(bottom: BorderSide.none)),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  //on-click event for rate app..
  Future<String> rateGatePass(BuildContext context) {
    return showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Love GatePass?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[600])
          ),
          content: TextFormField(
            controller: myTextController,
            maxLines: 3,
            decoration: InputDecoration(
              suffix: suffix ?? SizedBox.fromSize(),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              hintText: 'Leave us a review...',
              hintStyle: TextStyle(
                fontSize: 13.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('SUBMIT',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.green[600],
                ),
              ),
              onPressed: (){
                Navigator.of(context).pop(myTextController.text.toString());
              },
            )
          ],
        );
      },
    );
  }
}

//bottom buttons props
// ignore: must_be_immutable
class BottomMenu extends StatelessWidget {
  String text;
  Function onTap;
  Border decoration;

  BottomMenu(this.text, this.onTap, this.decoration);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      splashColor: Colors.green[500],
      child: Container(
        decoration: BoxDecoration(
          border: decoration,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child:
              Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
