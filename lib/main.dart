import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xgateapp/core/models/notification/notification_types.dart';
import 'package:xgateapp/pages/payment/payment_method.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/providers/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


void main() async{
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
    new Timer.periodic(Duration(minutes: 10), (Timer t)async{
      if(await getUserTypeProvider(context).getUserType != null && await appIsConnected() == true && await authToken(context) != null){
          loadInitialProfile(context);
      if(getFCMTokenProvider(context).loadedToServer == false && getFCMTokenProvider(context).loading != true){
        if (getFCMTokenProvider(context).fcmToken != null){
          setFCMTokenInServer(context);
        } else {
          if (_firebaseMessaging != null){
             _firebaseMessaging.getToken().then((token) async{
          getFCMTokenProvider(context).setFCMToken(fcmToken: token);
          appIsConnected().then((isConnected)async{
            if (isConnected == true && getFCMTokenProvider(context).loading !=true && await authToken(context) != null){
              setFCMTokenInServer(context);
      }
    });
    
    });
          }
        }
        
      }
      if (await getUserTypeProvider(context).getUserType == user_type.RESIDENT){
        loadGateManThatAccepted(context);
        loadInitialVisitors(context);
        loadScheduledVisitors(context);
        loadResidentsVisitorHistory(context);
        loadGateManThatArePending(context);
        loadResidentNotificationFromApi(context);
       
       }else if(
         await getUserTypeProvider(context).getUserType == user_type.GATEMAN){

      } 
      }


    });


    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {});
    });
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: (String payload) async {
          if(payload != null){
          dynamic jsonPayload = json.decode(payload);
          String route = jsonPayload['route'];
          if (route!=null && route.length > 0){
              // Navigator.pushNamed(navigatorKey.currentContext, route);
              navigatorKey.currentState.pushNamed(route);
          }
          } 
        });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          handleOnNotificationReceived(message,viewWhen: 'onMessage');
          
          
          
          
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
    _firebaseMessaging.getToken().then((token) async{
    getFCMTokenProvider(context).setFCMToken(fcmToken: token);
    appIsConnected().then((isConnected)async{
      if (isConnected == true && getFCMTokenProvider(context).loading !=true && await authToken(context) != null){
        setFCMTokenInServer(context);
      }
    });
    
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    appIsConnected().then((isConnected)async{
      if (isConnected == true){
        if(await authToken(context) !=null && getFCMTokenProvider(context).fcmToken !=null && getFCMTokenProvider(context).loading !=true && getFCMTokenProvider(context).loadedToServer != true){
          
          setFCMTokenInServer(context);
        }
      }

    });

    return MaterialApp(
      title: 'GateMan App',
      // initialRoute: '/',
      // initialRoute: '/',
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primarySwatch: GateManColors.primarySwatchColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: GateManColors.textColor,
              displayColor: GateManColors.textColor,
            ),
        fontFamily: 'OpenSans',
      ),
      // home: PaymentMethod(),
      debugShowCheckedModeBanner: false
    );
  }

  showNotification(Map<String, dynamic> msg,{Map<String,String> payload}) async {
    var android = AndroidNotificationDetails(
      'id-general',
      "general",
      "general notification",
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker'
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    // try{
    await flutterLocalNotificationsPlugin.show(
        0, msg['notification']['title'] ?? 'GateGuard', msg['notification']['body'] ?? 'GateGuard', platform,
        payload: json.encode(payload ?? ''));
    // } catch(error){
    //   th
    // }
  }

  Future handleOnNotificationReceived(dynamic message,{String viewWhen}) async {
    String authTokenStr = await authToken(context);
    if (authTokenStr != null) {
      if (await getUserTypeProvider(context).getUserType ==
          user_type.RESIDENT) {
        //handle resident notifications
        handleOnNotiicationReceivedForResident(message,viewWhen: viewWhen);
      } else if (await getUserTypeProvider(context).getUserType ==
          user_type.GATEMAN) {
        //handle gateman notifications
        handleOnNotiicationReceivedForGateman(message,viewWhen:"onMessage");
      }
    }
  }

  void handleOnNotiicationReceivedForResident(Map<String, dynamic> message,{String viewWhen}) {
    String type = message['data']['type'];
    getResidentNotificationProvider(context).setLoadedFromApi(false);
    getResidentsGateManProvider(context)
            .setLoadedFromApi(stat: false, pendingStat: false);
      print(type);
    switch (type) {
      case GateGuardNotificationType.gateManAcceptedRequest:
      
      moveGateManToAccepted(context: context, gateman_id: message['data']['gateman_id'] is String?int.parse( message['data']['gateman_id']): message['data']['gateman_id']);
           if (ModalRoute.of(navigatorKey.currentContext)?.settings?.name != '/manage-gateman'){
              
       if (viewWhen != 'onMessage'){
         navigatorKey.currentState.pushNamed('/manage-gateman');
           } else {
             showNotification(message.cast<String,dynamic>(),payload:{"route":"/manage-gateman"});
           }
        } else{
          if (viewWhen == 'onMessage'){
           showNotification(message.cast<String,dynamic>());
          }
         
        }
        break;

      case GateGuardNotificationType.visitorCheckedOutNotification:
      

          if (ModalRoute.of(context)?.settings?.name != '/resident-notifications'){
             if (viewWhen != 'onMessage'){
              navigatorKey.currentState.pushNamed('/resident-notifications');

           }else {
             showNotification(message.cast<String,dynamic>(),payload:{"route":"/resident-notifications"});
           }
        } else{
          if (viewWhen == 'onMessage'){
          showNotification(message.cast<String,dynamic>());
          }

        }
        break;


    

      case GateGuardNotificationType.visitorArrivalNotification:
      print(message['data']);
      Map<String,dynamic> vd = json.decode(message['data']['visitor_details']);
      print(vd['id']);
      removeVisitorFromScheduled(context: context, visitor_id: vd['id'] is String?int.parse(vd['id']):vd['id'],);
           if (ModalRoute.of(context)?.settings?.name != '/resident-notifications'){
             if (viewWhen != 'onMessage'){
              navigatorKey.currentState.pushNamed('/resident-notifications');

           }else {
             showNotification(message.cast<String,dynamic>(),payload:{"route":"/resident-notifications"});
           }
        } else{
          if (viewWhen == 'onMessage'){
          showNotification(message.cast<String,dynamic>());
          }

        }
        break;

      default:
        break;
    }
    setState(() {
      
    });
  }

  void handleOnNotiicationReceivedForGateman(message,{String viewWhen}) {
    if (viewWhen != null && viewWhen == 'onMessage'){

      showNotification(message.cast<String,dynamic>());

    }


  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data']['type'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
