import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/utils/intro_view/Models/pager_indicator_view_model.dart';

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
  double _currentPageIndex = 0;
  List<Color> pageIndicatorColors = [Color(0xFFFFDA58), Colors.white];
  final PageController _controller = PageController();
  final List<String> pagerMessages = [
    'Manage your Visitors peacefully',
    'Deny access to unwanted visitors'
  ];

  final List<String> pagerSubMessages = [
    'Save them the embarrassment of waiting needlessly for permission',
    'Get some gate guards to help you as easily as it should be,.'
  ];

  final List<String> pagerImages = [
    'assets/images/pager-1.png',
    'assets/images/pager-2.png'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _controller.addListener(() {
       print(_controller.page);
        setState(() {
          _currentPageIndex = _controller.page;
        });

  });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.black,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));

   

    return buildSlidable();
  }

  Widget buildSlidable(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
                  child: PageView(
            controller: _controller,
            children: <Widget>[
              buildSubPage(0),
              buildSubPage(1)

          ],
                    ),
        ),Container(
          decoration: BoxDecoration(
                   color: GateManColors.primaryColor
                 ),
          child: Padding(
            padding: const EdgeInsets.only(left:24.0),
            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPageIndex == 0?pageIndicatorColors[0]:pageIndicatorColors[1]
                                ),),
                            ),
                              Container(
                                 width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPageIndex == 1?pageIndicatorColors[0]:pageIndicatorColors[1]
                              ),)
                          ],),
                           FlatButton(
                            onPressed: () async{
                              GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
                              if (geolocationStatus == GeolocationStatus.denied || geolocationStatus == GeolocationStatus.disabled || geolocationStatus == GeolocationStatus.restricted){
                                return Navigator.pushReplacementNamed(
                                context, '/add-location');
                              } else {
                                return Navigator.pushReplacementNamed(
                                context, '/user-type');
                              }
                              
                            },
                            child: Text(
                              'SKIP',
                              style: TextStyle(color: Colors.white),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 5.0),
                          ),

                        
                        ],),
          ),
        )
         
      ],
    );
  }

  Widget buildSubPage(int index){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 20),
                  child: Text(index==0?'Welcome':'',textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 42.0, color: GateManColors.primaryColor)))
        ),
                        Expanded(
                                                  child: Container(
                  child: Image.asset(pagerImages[index],
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.width/2,),
                ),
               
               ), 
               Expanded(child: Container(
                 width: MediaQuery.of(context).size.width,
                 child:  Padding(
                       padding: const EdgeInsets.all(24.0),
                       child: Column(
                   mainAxisSize: MainAxisSize.max,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                  pagerMessages[index],
                  style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ), Padding(
                  padding: const EdgeInsets.only(top:24.0),
                  child: Text(
                    pagerSubMessages[index],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                      ],
                    ),
                    
                    

                   
                   ],
                 ),
                 ),
                 decoration: BoxDecoration(
                   color: GateManColors.primaryColor
                 ),),)

              

                



      ],
    );
  }
}
// Container(
//       height: double.infinity,
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Align(
//             alignment: Alignment.topLeft,
//             child: Padding(
//                 padding: EdgeInsets.only(top: 40.0, left: 40.0),
//                 child: Text(_currentPageIndex == 0 ? 'Welcome' : '',
//                     style: TextStyle(
//                         fontSize: 42.0, color: GateManColors.primaryColor))),
//           ),
//           Spacer(),
//           Container(
//             height: size.height * 0.4,
//             width: double.infinity,
//             child: PageView(
//               scrollDirection: Axis.horizontal,
//               controller: _controller,
//               children: <Widget>[
//                 Container(
//                   child: Image.asset('assets/images/pager-1.png'),
//                 ),
//                 Container(
//                   child: Image.asset(
//                     'assets/images/pager-2.png',
//                     width: double.infinity,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(20.0),
//             height: size.height * 0.4,
//             color: GateManColors.primaryColor,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   pagerMessages[_currentPageIndex],
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 SizedBox(height: 20.0),
//                 Text(
//                   pagerSubMessages[_currentPageIndex],
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 Spacer(),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             width: 10.0,
//                             height: 10.0,
//                             decoration: BoxDecoration(
//                                 color: pageIndicatorColors[0],
//                                 shape: BoxShape.circle),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Container(
//                             width: 10.0,
//                             height: 10.0,
//                             decoration: BoxDecoration(
//                                 color: pageIndicatorColors[1],
//                                 shape: BoxShape.circle),
//                           )
//                         ],
//                       ),
//                       Spacer(),
//                       FlatButton(
//                         onPressed: () async{
//                           GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
//                           if (geolocationStatus == GeolocationStatus.denied || geolocationStatus == GeolocationStatus.disabled || geolocationStatus == GeolocationStatus.restricted){
//                             return Navigator.pushReplacementNamed(
//                             context, '/add-location');
//                           } else {
//                             return Navigator.pushReplacementNamed(
//                             context, '/user-type');
//                           }
                          
//                         },
//                         child: Text(
//                           'SKIP',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 5.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
  