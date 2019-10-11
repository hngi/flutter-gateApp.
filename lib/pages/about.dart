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
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'About GatePass'),
      body: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: Ed
            )
          ],
        ),
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

 void _shareIt(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),

                  child: Text(
                    'Share via...',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),

              GridView.count(
                crossAxisCount: 3,
                primary: false,
                shrinkWrap: true,
                children: <Widget>[
                  _ShareOption('assets/images/OfficerAsset.png', 'Gmail')
                ],
              ),

            ],
          );
        }
    );
 }
}

Widget _ShareOption (String img, String text) {
    return Padding(
      padding: EdgeInsets.all(15.0),

      child: Container(
        child: Stack(
          children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Container(
                height: 125.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)
                    ),
                    image: DecorationImage(
                        image: AssetImage(img),
                    )
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0
                ),
              ),
            ),
             ]
           )
          ],
        ),
      ),

    );
//  child: Stack(
//    children: <Widget>[
//      Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//            height: 125.0,
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage(img),
//                    fit: BoxFit.cover
//                )
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
//            child: Text(
//              text,
//              style: TextStyle(
//                  fontFamily: 'Montserrat',
//                  fontSize: 15.0
//              ),
//            ),
//          ),
//      ]
//    )
//  )
}

//bottom buttons props
class bottom_menu extends StatelessWidget {
  String text;
  Function onTap;
  Border decoration;

  bottom_menu(this.text, this.onTap, this.decoration);

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
