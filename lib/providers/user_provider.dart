import 'package:flutter/widgets.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserTypeProvider extends ChangeNotifier {
  user_type type = user_type.RESIDENT;
  bool firstRunStatus = true;
  bool loggingOut = false;
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
    'ADMIN':'/gateman-menu',
    'GATEMAN':null
  };

  setFirstRunStatus(bool status,{bool loggingoutStatus}){
    firstRunStatus = status;
    loggingOut = loggingoutStatus??loggingOut;
    notifyListeners();
  }

  
  

  void setUserType(user_type type) async{
    this.type = type;
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
