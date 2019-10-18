import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';

class ResidentsNotificationList extends StatefulWidget {
  final String name, time;

  ResidentsNotificationList({
    this.name,
    this.time,
  });
  @override
  _ResidentsNotificationListState createState() =>
      _ResidentsNotificationListState();
}

class _ResidentsNotificationListState extends State<ResidentsNotificationList> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(children: <Widget>[
        InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                ),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 6.0,
              left: 20.0,
            ),
            child: Text(
              widget.time,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ]),
      ]),
      Container(
        padding: EdgeInsets.only(left: 300.0),
        child: PopupMenuButton(
            offset: Offset(0, 100),
            itemBuilder: (context) => [
                  PopupMenuItem(
                      child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text(
                      'Delete this notification',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  )),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.notifications_off),
                      title: Text(
                        "Turn off",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Turn off this notification',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ]),
      )
    ]);
  }
}