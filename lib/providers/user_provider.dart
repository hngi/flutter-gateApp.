import 'package:flutter/widgets.dart';
import 'package:xgateapp/core/models/old_user.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserTypeProvider extends ChangeNotifier {
  user_type type = user_type.RESIDENT;
  bool firstRunStatus = true;
  bool loggeOut = false;
  String userTypeStr;
  Map<String, dynamic> userTypeMap  = {
    "RESIDENT":user_type.RESIDENT,
    "ADMIN" : user_type.ADMIN,
    "GATEMAN": user_type.GATEMAN,
  };
  Map<dynamic,String> userTypeMapToStr = {
    user_type.RESIDENT: 'RESIDENT',
    user_type.ADMIN: 'ADMIN',
    user_type.GATEMAN:'GATEMAN'
  };

  Map<String,String> userRouteMapToStr = {
    'RESIDENT':'/welcome-resident',
    'GATEMAN':'/gateman-menu',
    'ADMIN':null
  };

  setFirstRunStatus(bool status,{bool loggedOut}){
    firstRunStatus = status;
    loggeOut = loggedOut??loggeOut;
    notifyListeners();
  }

  
  

  void setUserType(user_type type) async{
    this.type = type;
    if(type == user_type.GATEMAN){userTypeStr = 'GATEMAN';}
    if(type == user_type.RESIDENT){userTypeStr = 'RESIDENT';}
    try{
    SharedPreferences prefs = await getPrefs;
    prefs.setString('user_type',userTypeMapToStr[type]);
    }catch(error){

      print(error);
      
    }
    notifyListeners();
  }

  Future<String> get getUserTypeRoute async{
    try{
        return userRouteMapToStr[userTypeStr];
    } catch(error){
      print(error);

    }
  }

  Future<user_type> get getUserType async{
    user_type userType;
    try{
    SharedPreferences prefs = await getPrefs;
    userTypeStr = prefs.getString('user_type');
    
    if (userTypeStr!=null){
      userType = userTypeMap[userTypeStr];
      
    }
    }catch(error){

      print(error);
      
    }
    return userType;

  }

}
