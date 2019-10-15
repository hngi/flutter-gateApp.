//bottom buttons props
// ignore: must_be_immutable
import 'package:flutter/material.dart';

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