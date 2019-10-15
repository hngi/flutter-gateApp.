import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String _userToken;

  String get authToken => _userToken;

  void setToken(String token) {
    _userToken = token;
    notifyListeners();
  }
}
