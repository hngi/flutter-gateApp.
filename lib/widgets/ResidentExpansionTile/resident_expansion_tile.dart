// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';

const Duration _kExpand = Duration(milliseconds: 500);

class ResidentExpansionTile extends StatefulWidget {
  const ResidentExpansionTile({
    Key key,
    @required this.fullName,
    @required this.phoneNumber,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    @required this.address,
    @required this.visitText,
    @required this.numberCount,
    @required this.visitorName,
    @required this.visitorPhoneNumber,
    @required this.visitorDescription,
    @required this.visitorETA,
    @required this.visitorVerifyNo,
    @required this.visitorApprovalStatus,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String fullName;
  final String address;
  final String phoneNumber;
  final String visitText;
  final String numberCount;
  final String visitorName;
  final String visitorPhoneNumber;
  final String visitorDescription;
  final String visitorETA;
  final String visitorVerifyNo;
  final String visitorApprovalStatus;

  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;

  @override
  ResidentExpansionTileState createState() => ResidentExpansionTileState();
}

class ResidentExpansionTileState extends State<ResidentExpansionTile>
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

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: GateManColors.primaryColor,
          style: BorderStyle.solid,
          width: .7,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      // padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      // margin: EdgeInsets.symmetric(vertical: 10.0),
      // decoration: BoxDecoration(
      //     // color: Colors.white,
      //     borderRadius: BorderRadius.circular(10.0),
      //     border: Border.all(color: GateManColors.primaryColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.value),
            child: GestureDetector(
              onTap: _handleTap,
              child: Container(
                  height: 83.0,
                  // padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(25.0),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.fullName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                                color: GateManColors.blackColor,
                              ),
                            ),

                            //location
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      color: Colors.black, size: 16.0),
                                  SizedBox(width: 6.0),
                                  Text(
                                    widget.address,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: GateManColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //phone
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.phone,
                                      color: Colors.black, size: 16.0),
                                  SizedBox(width: 6.0),
                                  Text(
                                    widget.phoneNumber,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                      color: GateManColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //Add Button
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: GateManColors.yellowColor,
                              ),
                              height: 28.0,
                              width: 95.0,
                              child: Text(widget.visitText,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500)),
                            ),

                            SizedBox(height: 9.0),

                            //Number count
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: GateManColors.primaryColor,
                              ),
                              height: 35.0,
                              width: 36.0,
                              child: Text(widget.numberCount,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Divider(
                    color: Colors.grey,
                    height: .4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Visitor Info',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.0,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.visitorApprovalStatus,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.0,
                            color: GateManColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextRow(
                    title: 'Name',
                    text: widget.visitorName,
                  ),
                  TextRow(
                    title: 'Phone Number',
                    text: widget.visitorPhoneNumber,
                  ),
                  TextRow(
                      title: 'Description', text: widget.visitorDescription),
                  TextRow(
                    title: 'ETA',
                    text: widget.visitorETA,
                  ),

                  //Verified with
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Verified With:",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.0,
                            color: GateManColors.blackColor,
                          ),
                        ),
                        Text(
                          widget.visitorVerifyNo,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: Colors.white,
                              backgroundColor: GateManColors.primaryColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class TextRow extends StatelessWidget {
  final String title;
  final String text;
  final Widget widget;

  const TextRow({
    Key key,
    @required this.title,
    @required this.text,
    this.widget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "$title:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15.0,
              color: GateManColors.blackColor,
            ),
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
