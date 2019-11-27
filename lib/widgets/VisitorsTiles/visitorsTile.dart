import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';

class VisitorTile extends StatefulWidget {
  final String name,
      group,
      phone,
      timeline,
      date,
      buttonText1,
      buttonText2,
      buttonText3,
      avatarLink,
      backUpAvatarLink = 'assets/images/avatar.png';
  final Function buttonFunc1, buttonFunc2,buttonFunc3;
  final VisitorModel model;
  final Function(bool) onSelectionchange;
  final bool selected, showCheckBox;

  VisitorTile(
      {Key key,
      @required this.selected,
      this.showCheckBox,
      @required this.name,
      @required this.group,
      @required this.phone,
      @required this.timeline,
      @required this.date,
      @required this.buttonText1,
      @required this.buttonText2,
      @required this.buttonFunc1,
      @required this.buttonFunc2,
      this.buttonFunc3,
      this.buttonText3,
      @required this.model,
      this.onSelectionchange,
      this.avatarLink = 'assets/images/avatar2.jpg'})
      : super(key: key);

  @override
  _VisitorTileState createState() => _VisitorTileState();
}

class _VisitorTileState extends State<VisitorTile> {
  bool drag = false;
  
  void toggle() {
    setState(() {
      drag = !drag;
    });
  }

  void toggleSelection(selected){
    setState(() {
     if(this.widget.onSelectionchange != null){
       this.widget.onSelectionchange(selected);
     }
     
    });
  }

  @override
  Widget build(BuildContext context) {
    bool selected = this.widget.selected;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: InkWell(
                onTap: (){toggleSelection(!selected);},
                child:CircleAvatar(
                backgroundImage: this.widget.avatarLink==null || this.widget.avatarLink == 'noimage.jpg'?AssetImage(this.widget.backUpAvatarLink):NetworkImage(Endpoint.imageBaseUrl+this.widget.avatarLink),
                radius: 30.0,
              )),
              title: InkWell(
                onLongPress: (){
                  // Navigator.pushNamed(context, '/visitor-profile',arguments: this.widget.model);
                  toggleSelection(!selected);
                },
                onTap: toggle,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w600),
                            ),
                            !drag
                                ? Row(
                                    children: <Widget>[
                                      drag
                                          ? Text("")
                                          : Text(
                                              widget.phone,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey),
                                            ),
                                      Text("")
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                        selected || (this.widget.showCheckBox != null && this.widget.showCheckBox)?
                        Checkbox(onChanged: (bool value) {
                          toggleSelection(value);
                        }, value: selected,

                        )
                        :
                        IconButton(
                            icon: Icon(
                                drag
                                    ? MdiIcons.chevronUp
                                    : MdiIcons.chevronDown,
                                color: Colors.green),
                            onPressed: toggle)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        drag && widget.group !=null && widget.group.toLowerCase() != 'none'
                            ? Text(
                                'Visitors Group: ${widget.group}',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              )
                            : Text(""),
                        drag
                            ? Text(
                                widget.timeline,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                                overflow: TextOverflow.fade,
                              )
                            : Text(""),
                      ],
                    ),
                  ],
                ),
              ),
              subtitle: drag
                  ? Column(children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            widget.phone,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                            overflow: TextOverflow.fade,
                          )),
                          Expanded(
                            child: Text(
                              prettifyDate(widget.date),
                                                            overflow: TextOverflow.fade,
                                                            style:
                                                                TextStyle(fontSize: 12.0, color: Colors.grey),
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15.0),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[this.widget.buttonText3!=null?
                                                         InkWell(
                                                          onTap: widget.buttonFunc3,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color: Colors.green),
                                                                borderRadius:
                                                                    BorderRadius.all(Radius.circular(3.0))),
                                                            padding: widget.buttonText3.length < 5
                                                                ? EdgeInsets.only(
                                                                    left: 15.0,
                                                                    right: 15.0,
                                                                    top: 2.0,
                                                                    bottom: 2.0)
                                                                : EdgeInsets.only(
                                                                    left: 5.0,
                                                                    right: 5.0,
                                                                    top: 2.0,
                                                                    bottom: 2.0),
                                                            child: Text(widget.buttonText3,
                                                                style: TextStyle(color: Colors.green)),
                                                          ),
                                                        ):Container(width: 0,height: 0,),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        InkWell(
                                                          onTap: widget.buttonFunc1,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color: Colors.green),
                                                                borderRadius:
                                                                    BorderRadius.all(Radius.circular(3.0))),
                                                            padding: widget.buttonText1.length < 5
                                                                ? EdgeInsets.only(
                                                                    left: 15.0,
                                                                    right: 15.0,
                                                                    top: 2.0,
                                                                    bottom: 2.0)
                                                                : EdgeInsets.only(
                                                                    left: 5.0,
                                                                    right: 5.0,
                                                                    top: 2.0,
                                                                    bottom: 2.0),
                                                            child: Text(widget.buttonText1,
                                                                style: TextStyle(color: Colors.green)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        InkWell(
                                                          onTap: widget.buttonFunc2,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                border: Border.all(color: Colors.green),
                                                                borderRadius:
                                                                    BorderRadius.all(Radius.circular(3.0))),
                                                            padding: EdgeInsets.only(
                                                                left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
                                                            child: Text(widget.buttonText2,
                                                                style: TextStyle(color: Colors.white)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 8.0),
                                                  ])
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              
                               
}