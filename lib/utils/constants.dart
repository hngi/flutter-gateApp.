import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gateapp/core/models/estate.dart';
import 'package:gateapp/core/service/profile_service.dart';
import 'package:gateapp/core/service/resident_service.dart';
import 'package:gateapp/core/service/visitor_sevice.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/providers/visitor_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GateManAlert/gateman_alert.dart';
import 'errors.dart';
import 'helpers.dart';

const CONNECT_TIMEOUT = 30000;
const RECEIVE_TIMEOUT = 30000;

Future<String> authToken(BuildContext context) async {
  // String authToken = '';

  return await Provider.of<TokenProvider>(
    context,
    listen: false,
  ).authToken;

  // return authToken;
}

Future<SharedPreferences> get getPrefs async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<String> get authTokenFromStorage async {
  SharedPreferences prefs = await getPrefs;
  return prefs.getString('authToken');
}

Future<user_type> userType(BuildContext context) async {
  return await Provider.of<UserTypeProvider>(context).getUserType;
}


UserTypeProvider getUserTypeProvider(BuildContext context){
  return Provider.of<UserTypeProvider>(context);
} 

ProfileProvider getProfileProvider(BuildContext context){

  return Provider.of<ProfileProvider>(context);
}

VisitorProvider getVisitorProvider(BuildContext context) {
  return Provider.of<VisitorProvider>(context);
}

ResidentsGateManProvider getResidentsGateManProvider(BuildContext context) {
  return Provider.of<ResidentsGateManProvider>(context);
}

Future loadInitialProfile(BuildContext context) async {
    print('Loading initial profile');
        try{
        dynamic response  = await ProfileService.getCurrentUserProfile(
          authToken: await authToken(context)
          );
          if(response is ErrorType){
            PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
            
          }else{
            //await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated');
                            print('Initial Profile Loaded');
                            print(ProfileModel.fromJson(response));
                            getProfileProvider(context).setProfileModel(
                            ProfileModel.fromJson(response),jsonString: json.encode(response));
          }
        } catch (error){
          print(error);
          await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(ErrorType.generic));
            
        }

      }


launchCaller({@required String phone, @required BuildContext context}) async {
  String url = "tel:$phone";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    PaysmosmoAlert.showError(
        context: context, message: 'Could not place a call to $phone');
  }
}

Future loadGateManThatAccepted(context) async {
  try {
    dynamic response =
        await ResidentsGatemanRelatedService.getGateManThatAccepted(
            authToken: await authToken(context));
    if (response is ErrorType) {
      PaysmosmoAlert.showError(
          context: context, message: GateManHelpers.errorTypeMap(response));
    } else {
      print(response);

      List<dynamic> responseData = response['data'];
      List<ResidentsGateManModel> models = [];
      responseData.forEach((jsonModel) {
        models.add(ResidentsGateManModel.fromJson(jsonModel));
      });
      getResidentsGateManProvider(context).setResidentsGateManModels(models);
    }
  } catch (error) {
    throw error;
  }
}

Future loadInitialVisitors(BuildContext context,{bool skipAlert}) async {
  try {
    dynamic response =
        await VisitorService.getAllVisitor(authToken: await authToken(context));
    if (response is ErrorType) {
      if (response == ErrorType.no_visitors_found) {
        getVisitorProvider(context).setInitialStatus(true);
        PaysmosmoAlert.showSuccess(
            context: context, message: GateManHelpers.errorTypeMap(response));
            getVisitorProvider(context).setVisitorModels([]);
      } else {
        PaysmosmoAlert.showError(
            context: context, message: GateManHelpers.errorTypeMap(response));
      }
    } else {
      if (response['visitor'] == 0) {
        PaysmosmoAlert.showSuccess(context: context, message: 'No visitors');
        getVisitorProvider(context).setVisitorModels([]);
      } else {
        print('linking data for visitors');
        print(response['visitor']);
        dynamic jsonVisitorModels = response['visitor'];
        List<VisitorModel> models = [];
        jsonVisitorModels.forEach((jsonModel) {
          models.add(VisitorModel.fromJson(jsonModel));
        });
        getVisitorProvider(context).setVisitorModels(models,jsonString:json.encode(response['visitor']));
        
        
        getUserTypeProvider(context).setFirstRunStatus(false,loggedOut: false);
      }
    }
  } catch (error) {
    throw error;
  }
}

//  Future loadInitialVisitors(BuildContext context) async {
                        
//                                 try {
                                
//                                   dynamic response = await VisitorService.getAllVisitor(
//                                       authToken: await authToken(context));
//                                   if (response is ErrorType) {
                                    
                                    
//                                      if(response == ErrorType.no_visitors_found){
//                                       getVisitorProvider(context).setInitialStatus(true);
//                                       PaysmosmoAlert.showSuccess(
//                                         context: context,
//                                         message: GateManHelpers.errorTypeMap(response));
//                                         getVisitorProvider(context).setVisitorModels([]);
//                                     }
//                                     else{
//                                       PaysmosmoAlert.showError(
//                                         context: context,
//                                         message: GateManHelpers.errorTypeMap(response));
//                                     }
                                     
                                        
//                                   } else {
//                                     if (response['visitor'].length == 0) {
//                                       PaysmosmoAlert.showSuccess(
//                                           context: context, message: 'No visitors');
//                                     } else {
//                                       print('linking data for visitors');
//                                       print(response['visitor'] );
//                                       dynamic jsonVisitorModels = response['visitor'] ;
//                                       List<VisitorModel> models = [];
//                                       jsonVisitorModels.forEach((jsonModel) {
//                                         models.add(VisitorModel.fromJson(jsonModel));
//                                       });
//                                       getVisitorProvider(context).setVisitorModels(models);
//                                       getUserTypeProvider(context).setFirstRunStatus(false);

                                    
//                                     }
//                                   }
//                                 } catch (error) {
//                                   throw error;
//                                 }
                            
//                                 }



void logOut(context) {
  Provider.of<TokenProvider>(context).clearToken();
  Provider.of<UserTypeProvider>(context).setFirstRunStatus(false,loggedOut: true); 
  Provider.of<ProfileProvider>(context).setProfileModel(ProfileModel());
  Provider.of<ProfileProvider>(context).loadedFromApi = false;
  Provider.of<ProfileProvider>(context).notifyListeners();
  Provider.of<VisitorProvider>(context).setVisitorModels([]);
  Provider.of<VisitorProvider>(context).loadedFromApi = false;
  Provider.of<ResidentsGateManProvider>(context).loadedFromApi = false;
  Provider.of<ResidentsGateManProvider>(context).clear();
  Provider.of<ResidentsGateManProvider>(context).pendingloadedFromApi = false;
  Navigator.pushNamedAndRemoveUntil(context, '/user-type',(Route<dynamic> route) => false);
  
  PaysmosmoAlert.showSuccess(context: context,message: 'Logout successful');        
}               

//UserType enum
enum user_type { ADMIN, GATEMAN, RESIDENT }

Future getImage(Function(File img) action, ImageSource source) async {
    File img = await ImagePicker.pickImage(source: source);

    action(img);

  }

   Future<bool> appIsConnected()async {
       ConnectivityResult connectivityResult  =  await  (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi  ){
try {
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
  }
} on SocketException catch (_) {
  return false;
}
            
} else if(connectivityResult == ConnectivityResult.none){
  return false;
  
} else{
  return false;
}
return false;

}

Future loadGateManThatArePending(context) async{
    try{
      dynamic response = await ResidentsGatemanRelatedService.getGateManThatArePending(authToken: await authToken(context));
      if(response is ErrorType){
        PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
      } else {
        print('gatemen yet to acept loading');
        print(response);

        List<dynamic> responseData = response['data'];
        List<ResidentsGateManModel> models= [];
        responseData.forEach((jsonModel){
          models.add(ResidentsGateManModel.fromJson(jsonModel));
          
        });

        getResidentsGateManProvider(context).setResidentsGateManAwaitingModels(models);
        return models;
      }
    }catch(error){
      throw error;
    }
  }


