import 'package:flutter/material.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  String _userToken;

  
  Future<String> get authToken async{
    if(_userToken==null){
      _userToken = await getTokenFromPrefs;
    }



     return _userToken;
  }

  Future<String> get getTokenFromPrefs async{
    try{
      SharedPreferences prefs = await getPrefs;
      return prefs.getString('authToken');
    } catch(error){
      print(error);
      return null;
    }

  }

  void setToken(String token) async{
    _userToken = token;
    try{
      SharedPreferences prefs = await getPrefs;
      prefs.setString('authToken', token);
    } catch(error){
      print(error);
    }

    
   
    
    notifyListeners();
  }

  



}
