

import 'package:flutter/material.dart';

class FCMTokenProvider extends ChangeNotifier{
  String fcmToken;

  bool loadedToServer = false;
  bool loading = false;

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

  setFCMTokenLoadedToServerStatus(bool stat){
    loadedToServer = stat;
    notifyListeners();
  }
}