import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VisitorTile extends StatefulWidget {
  final String name, relation, phone, timeline, date, buttonText1, buttonText2, avatarLink;
  final Function buttonFunc1, buttonFunc2;

  const VisitorTile({Key key, @required this.name,  @required this.relation,  @required this.phone,  @required this.timeline,  @required this.date,  @required this.buttonText1,  @required this.buttonText2,  @required this.buttonFunc1,  @required this.buttonFunc2,  this.avatarLink = 'assets/images/avatar2.jpg'}) : super(key: key);
  
  @override
  _VisitorTileState createState() => _VisitorTileState();
}

class _VisitorTileState extends State<VisitorTile> {
  bool drag = false;
  void toggle(){
    setState(() {
     drag = !drag; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:4.0, bottom:4.0),
      child: Container(decoration: BoxDecoration(border: Border.all(color:Colors.grey.withOpacity(0.3)), borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(widget.avatarLink), radius: 30.0,),
              title: InkWell(onTap: toggle,
                child: Column(
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15.0,),
                            Text(widget.name, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                            !drag ? Row(
                      children: <Widget>[
                        drag ? Text("") : Text(widget.phone, style: TextStyle(fontSize: 12.0, color: Colors.grey),),
                        Text("")
                      ],
                    ):Container(),
                          ],
                        ),
                        IconButton(icon : Icon(drag ? MdiIcons.chevronUp : MdiIcons.chevronDown,color:Colors.green), onPressed: toggle)
                      ],
                    ),
                    
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        drag ? Text(widget.relation, style: TextStyle(fontSize: 14.0, color: Colors.grey),) : Text(""),
                        drag ? Text(widget.timeline, style: TextStyle(fontSize: 14.0, color: Colors.grey), overflow: TextOverflow.fade,) : Text(""),
                      ],
                    ),
                  ],
                ),
              ),
              subtitle: drag ? 
            Column(children: <Widget>[
              Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(widget.phone, style: TextStyle(fontSize: 12.0, color: Colors.grey), overflow: TextOverflow.fade,)),
                Expanded(child: Text(widget.date, overflow: TextOverflow.fade, style: TextStyle(fontSize: 12.0, color: Colors.grey), textAlign: TextAlign.right,),),
              ],
            ),
            SizedBox(height:15.0),
            Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(onTap: widget.buttonFunc1,
                          child: Container(decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.green), borderRadius: BorderRadius.all(Radius.circular(3.0)) ), padding: widget.buttonText1.length < 5 ? EdgeInsets.only(left:15.0, right:15.0, top:2.0, bottom:2.0):EdgeInsets.only(left:5.0, right:5.0, top:2.0, bottom:2.0),
                            child: Text(widget.buttonText1, style: TextStyle(color: Colors.green)),
                            ),
                        ),
                        SizedBox(width: 10.0,),
                        InkWell(onTap: widget.buttonFunc2,
                          child: Container(decoration: BoxDecoration(color: Colors.green, border: Border.all(color: Colors.green), borderRadius: BorderRadius.all(Radius.circular(3.0))), padding: EdgeInsets.only(left:5.0, right:5.0, top:2.0, bottom:2.0),
                            child: Text(widget.buttonText2, style: TextStyle(color: Colors.white)),
                            ),
                        )
                      ],
                    ),
                    SizedBox(height:8.0),
             ])
            : Container(),
            ),
            
          ],
        ),
      ),
    );
  }
}