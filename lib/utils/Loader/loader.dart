import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader {
  Loader._();

  static Widget show({String message = 'Loading..'}) {
    _MyDialog _dialog = new _MyDialog(message: message);

    return Dialog(
        insetAnimationCurve: Curves.easeInOut,
        insetAnimationDuration: Duration(milliseconds: 100),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: _dialog);
  }
}

// ignore: must_be_immutable
class _MyDialog extends StatefulWidget {
  String message;
  _MyDialog({this.message});

  var _dialog = new _MyDialogState();

  update() {
    _dialog.changeState();
  }

  @override
  // ignore: must_be_immutable
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _MyDialogState extends State<_MyDialog> {
  changeState() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('Loader dismissed by back button');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100.0,
        child: Row(children: <Widget>[
          const SizedBox(width: 15.0),
          SizedBox(
            width: 60.0,
            child: Image.asset(
              'assets/gateman_spinner.gif',
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
              child: Text(widget.message,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700)))
        ]));
  }
}

class MessageBox {
  BuildContext buildContext;
  String message = " ", title = " ";

  MessageBox(this.buildContext, this.message, this.title);

  void show() {
    _showDialog();
  }

  Future _showDialog() {
    showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('$title'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          content: SizedBox(
            height: 45.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
    return null;
  }
}
