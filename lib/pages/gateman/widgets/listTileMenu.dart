import 'package:flutter/material.dart';

class ListTileMenu extends StatelessWidget {
  final String title;
  final Function func;
  final bool alert;
  final IconData icon;
  ListTileMenu({this.title, this.func, this.alert = false, this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green,),
      title: Row(
        children: <Widget>[
          Text(title),
          alert ? Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6),),
                            constraints: BoxConstraints(minWidth: 12,minHeight: 12,),
                            child: new Text('1',style: new TextStyle(color: Colors.white,fontSize: 8,),textAlign: TextAlign.center,),
                          ) : Container(),
        ],
      ),
    );
  }
}