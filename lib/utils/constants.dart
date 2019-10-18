import 'package:flutter/material.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
const CONNECT_TIMEOUT = 30000;
const RECEIVE_TIMEOUT = 30000;

Future<String> authToken(BuildContext context) async {
  return await Provider.of<TokenProvider>(context).getTokenFromPrefs;
}

Future<String> get authTokenFromStorage async{
  SharedPreferences prefs =  await getPrefs;
 return prefs.getString('authToken');


}

Future<SharedPreferences> get getPrefs async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs;
  }

Future<user_type> userType(BuildContext context) async{
  return await Provider.of<UserTypeProvider>(context).getUserType;
}


ProfileProvider getProfileProvider(BuildContext context){
  return Provider.of<ProfileProvider>(context);
}



//UserType enum
enum user_type { ADMIN, GATEMAN, RESIDENT }
