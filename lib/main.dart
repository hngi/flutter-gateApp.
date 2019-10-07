import 'package:flutter/material.dart';

import 'pages/SplashScreen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.green
  ),
  home: SplashScreen(),
));

