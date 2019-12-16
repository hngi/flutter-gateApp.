import 'package:flutter/material.dart';

Widget get raveLogo=>Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Text('rave',style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold),),
                                               Padding(
                                                 padding: const EdgeInsets.only(left:8.0),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: <Widget>[
                                                     Text('By flutterwave',style: TextStyle(fontSize: 10,color: Colors.grey),),
                                                   ],
                                                 ),
                                               ),
                                            ],
                                          );