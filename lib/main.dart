import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/pages/add_permission.dart';
import 'package:xgateapp/providers/faqBloc.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/providers/providers.dart';

void main() => runApp(GateMan());

class GateMan extends StatefulWidget {
  @override
  _GateManState createState() => _GateManState();
}

class _GateManState extends State<GateMan> {
  dynamic subscription;
  @override
  void dispose() {
    subscription.dispose();
    super.dispose();
  }
  @override
  initState(){
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('Connection just changed');
      setState(() {
        
      });
    // Got a new connectivity status!
  });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: providers,
      child: ChangeNotifierProvider<FaqBloc>.value(
        value: FaqBloc(),
        child: MaterialApp(
          title: 'GateMan App',
          initialRoute: '/',
          onGenerateRoute: Routes.generateRoute,
          theme: ThemeData(
            primarySwatch: GateManColors.primarySwatchColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: GateManColors.textColor,
                  displayColor: GateManColors.textColor,
                ),
            fontFamily: 'OpenSans',
          ),
          // home: ScanQRCode(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
