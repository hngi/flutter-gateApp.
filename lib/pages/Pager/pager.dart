import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/utils/colors.dart';

import 'package:gateapp/utils/helpers.dart';

class Pager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: MainPager());
  }
}

class MainPager extends StatefulWidget {
  @override
  _MainPagerState createState() => _MainPagerState();
}

class _MainPagerState extends State<MainPager> {
  int _currentPageIndex = 0;
  List<Color> pageIndicatorColors = [Color(0xFFFFDA58), Colors.white];
  final PageController _controller = PageController();
  final List<String> pagerMessages = [
    'Manage your\nVisitors peacefully',
    'Deny access to\nunwanted visitors'
  ];

  final List<String> pagerSubMessages = [
    'Save them the embarrassment of waiting needlessly for permission',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit,.'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.black,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));

    _controller.addListener(() {
      if (_controller.page == 0) {
        setState(() {
          _currentPageIndex = 0;
          pageIndicatorColors[0] = Color(0xFFFFDA58);
          pageIndicatorColors[1] = Colors.white;
        });
      } else if (_controller.page == 1.0) {
        setState(() {
          _currentPageIndex = 1;
          pageIndicatorColors[0] = Colors.white;
          pageIndicatorColors[1] = Color(0xFFFFDA58);
        });
      }
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(top: 70.0, left: 40.0),
                child: Text(_currentPageIndex == 0 ? 'Welcome' : '',
                    style: TextStyle(
                        fontSize: 42.0, color: GateManColors.primaryColor))),
          ),
          Spacer(),
          Container(
            height: size.height * 0.4,
            width: double.infinity,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: <Widget>[
                Container(
                  child: Image.asset('assets/images/pager-1.png'),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/pager-2.png',
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            height: size.height * 0.4,
            color: GateManColors.primaryColor,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pagerMessages[_currentPageIndex],
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 26.0),
                Text(
                  pagerSubMessages[_currentPageIndex],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: pageIndicatorColors[0],
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: pageIndicatorColors[1],
                                shape: BoxShape.circle),
                          )
                        ],
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, '/edit-profile'),
                        child: Text(
                          'SKIP',
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 5.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
