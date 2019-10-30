

import 'package:flutter/material.dart';

class FCMTokenProvider extends ChangeNotifier{
  String fcmToken;

  bool loadedToServer;
  bool loading;

  setFCMToken({@required fcmToken}){
    this.fcmToken = fcmToken;
  }

  clear(){
    fcmToken = null;
    notifyListeners();
  }

  setLoadingState(bool stat){
    loading = stat;
    notifyListeners();
  }

  setFCMTokenLoadeToServerStatus(bool stat){
    loadedToServer = stat;
    notifyListeners();
  }
}