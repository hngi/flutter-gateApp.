// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:flutter_sms/flutter_sms.dart';

const Duration _kExpand = Duration(milliseconds: 500);

class GateManExpansionTile extends StatefulWidget {
  const GateManExpansionTile({
    Key key,
    @required this.fullName,
    @required this.phoneNumber,
    @required this.dutyTime,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    @required this.onDeletePressed,
    @required this.onPhonePressed,
    @required this.onMessagePressed,
    this.onSmsPressed,
    this.smsController
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String fullName;
  final String phoneNumber;
  final ValueChanged<bool> onExpansionChanged;
  final String dutyTime;
  final bool initiallyExpanded;
  final Function onDeletePressed,onMessagePressed,onPhonePressed;
  final Function(String) onSmsPressed;
  final TextEditingController smsController;

  @override
  GateManExpansionTileState createState() => GateManExpansionTileState();
}

class GateManExpansionTileState extends State<GateManExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _borderColor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;
  Animation<Color> _backgroundColor;

  bool _isExpanded = false;
  bool sms = false;
  TextEditingController _smscontroller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
    _smscontroller = new TextEditingController(text: 'Please be my gateman bro');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collape() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            if (!mounted) return;
            setState(() {
              // Rebuild without gateman icons
            });
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null)
        widget.onExpansionChanged(_isExpanded);
    }
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without gateman icons
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }
  
  void openSms(){
    setState(() { 
      sms = !sms;
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: GateManColors.primaryColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.value),
            child: Container(
              // padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(25.0),
                  ),
              child: ListTile(
                // contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                onTap: _handleTap,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    widget.fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: GateManColors.blackColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.phone,
                          color: GateManColors.primaryColor, size: 16.0),
                      SizedBox(width: 6.0),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    widget.dutyTime != null
                        ? Text(widget.dutyTime,
                            style: TextStyle(
                                color: GateManColors.grayColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600))
                        : SizedBox(),
                    SizedBox(width: 8.0),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: GateManColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColorTween..end = Colors.transparent;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      //Phone
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: GateManColors.primaryColor,
                        ),
                        height: 50.0,
                        width: 50.0,
                        child: IconButton(icon:Icon(Icons.phone, color: Colors.white, size: 22.0),onPressed: this.widget.onPhonePressed,)
                      ),

                      //Message
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: GateManColors.primaryColor,
                        ),
                        height: 50.0,
                        width: 50.0,
                        child: IconButton(icon:Icon(Icons.message, color: Colors.white, size: 22.0),onPressed: openSms,)
                      ),

                      //Delete
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: GateManColors.primaryColor,
                        ),
                        height: 50.0,
                        width: 50.0,
                        child: IconButton( icon:Icon(Icons.delete, color: Colors.white, size: 22.0), onPressed:this.widget.onDeletePressed,),
                      ),
                    ],
                  ),
                  sms?Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Material(elevation: 10.0, shadowColor: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                                          child: TextFormField(controller: this.widget.smsController, decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Message', hintStyle: TextStyle(color: Colors.blueGrey.withOpacity(0.5)), contentPadding: EdgeInsets.only(top:13.0, left: 20.0),
                               
                              ),),
                            ),
                            InkWell(child: Column(
                            children: <Widget>[
                              Icon(Icons.send, color: Colors.green,),
                              Text("Send", style: TextStyle(color: Colors.green, fontSize: 11.0, fontWeight: FontWeight.w600),)
                            ],
                          ), onTap: this.widget.onSmsPressed(this.widget.smsController.text),)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:25.0, top: 10.0),
                      child: Text('Note: Standered Carrier SMS rate\napply for messages sent', style: TextStyle(fontSize: 12.0),),
                    )
                  ],)
                  :Container()
                ],
              ),
            ),
    );
  }
}
