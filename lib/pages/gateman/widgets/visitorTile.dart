import 'package:flutter/material.dart';
import 'package:gateapp/pages/gateman/widgets/button.dart';

class VisitorTile extends StatefulWidget {
  final String name, address, time;
  final Color color;
  final Function func;
  VisitorTile({this.name, this.address, this.color, this.time, this.func});
  @override
  _VisitorTileState createState() => _VisitorTileState();
}

class _VisitorTileState extends State<VisitorTile> {
  bool drag = false;
  void dragging(){
    setState(() {
     drag = !drag; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(0.0), margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              children: <Widget>[
                ListTile(onTap: dragging,
                  title: Text(widget.name, style: TextStyle(fontSize: 14.0,)),
                  subtitle: Row(children: <Widget>[
                        Icon(Icons.location_on, size: 14.0, color: Color(0xff4F4F4F)),
                        Text(widget.address, style: TextStyle(fontSize: 11.0,))
                      ],),
                  trailing: InkWell(onTap: (){},
                    child: Container(padding: const EdgeInsets.all(8.0), margin: const EdgeInsets.only(bottom: 3.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), color: widget.color),
                      child: Text(widget.time, style: TextStyle(color: Color(0xff4F4F4F), fontSize: 9.0, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                drag ? 
                Padding(
                  padding: const EdgeInsets.only(left:20.0, bottom: 20.0, right: 20.0),
                  child: Button(text: 'ALLOW VISITOR IN', func: widget.func, color: Colors.green, width: double.infinity, weight: FontWeight.w600,),
                )
                : Container(),
              ],
            ),
          );
  }
}