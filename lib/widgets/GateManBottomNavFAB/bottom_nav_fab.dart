import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavFAB extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;

  const BottomNavFAB({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: 150.0,
      child: FloatingActionButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 30.0),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 13.0))
          ],
        ),
        backgroundColor: GateManColors.primaryColor,
        elevation: 17.0,
        onPressed: onPressed,
      ),
    );
  }
}
