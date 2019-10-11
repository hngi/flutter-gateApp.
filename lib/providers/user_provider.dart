import 'package:flutter/widgets.dart';
import 'package:gateapp/core/models/user.dart';

class UserProvider extends ChangeNotifier {
  user_type type;

  //nothing yet
  
}

class UserTypeProvider extends ChangeNotifier{
  user_type type = user_type.RESIDENT;

  void setUserType(user_type type){
    this.type = type;
    notifyListeners();
  }
}


