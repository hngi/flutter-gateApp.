import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:xgateapp/pages/add_permission.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xgateapp/providers/faqBloc.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/providers/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:xgateapp/utils/constants.dart';

void main() {
  var gateMan = MultiProvider(
    child: GateMan(),
    providers: providers,
  );
  return runApp(gateMan);
}

class GateMan extends StatefulWidget {
  @override
  _GateManState createState() => _GateManState();
}

class _GateManState extends State<GateMan> {
  dynamic subscription;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void dispose() {
    subscription.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Connection just changed');
      setState(() {});
      // Got a new connectivity status!
    });
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: (String payload) async {});
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          handleOnNotificationReceived(message);
        },
        onResume: (Map<String, dynamic> message) {
          handleOnNotificationReceived(message);
        },
        onLaunch: (Map<String, dynamic> message) {
          handleOnNotificationReceived(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler);
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
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
      // home: ScanQRCode(),
    );
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, msg['title'] ?? 'GateGuard', msg['body'] ?? 'GateGuard', platform,
        payload: msg['data'] ?? '');
  }

  handleOnNotificationReceived(dynamic message) async {
    String authTokenStr = await authToken(context);
    print(authTokenStr);
    if (authTokenStr != null && await getUserTypeProvider(context).getUserType != user_type.RESIDENT) {
      //handle common notifications
      print(authTokenStr);
      print('on message to Gateman $message');
      if(await getUserTypeProvider(context).getUserType == user_type.RESIDENT){
        //handle resident notifications
        handleOnNotiicationReceivedForResident(message);
        
              } else if(await getUserTypeProvider(context).getUserType == user_type.GATEMAN){
                //handle gateman notifications
                handleOnNotiicationReceivedForGateman(message);
                              }
                          }
                          }
                        
                          void handleOnNotiicationReceivedForResident(message) {}
                
                  void handleOnNotiicationReceivedForGateman(message) {}
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
