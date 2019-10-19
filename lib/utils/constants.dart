import 'package:flutter/material.dart';
import 'package:gateapp/core/service/profile_service.dart';
import 'package:gateapp/core/service/resident_service.dart';
import 'package:gateapp/core/service/visitor_sevice.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/providers/visitor_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GateManAlert/gateman_alert.dart';
import 'errors.dart';
import 'helpers.dart';
const CONNECT_TIMEOUT = 30000;
const RECEIVE_TIMEOUT = 30000;

Future<String> authToken(BuildContext context) async {
  return await Provider.of<TokenProvider>(context).authToken;
}

Future<SharedPreferences> get getPrefs async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<String> get authTokenFromStorage async{
  SharedPreferences prefs =  await getPrefs;
 return prefs.getString('authToken');


}

Future<user_type> userType(BuildContext context) async {
  return await Provider.of<UserTypeProvider>(context).getUserType;
}

ProfileProvider getProfileProvider(BuildContext context){
  return Provider.of<ProfileProvider>(context);
}

VisitorProvider getVisitorProvider(BuildContext context){
  return Provider.of<VisitorProvider>(context);
}

ResidentsGateManProvider getResidentsGateManProvider(BuildContext context){
  return Provider.of<ResidentsGateManProvider>(context);
}

Future loadInitialProfile(BuildContext context) async {
        try{
        dynamic response  = await ProfileService.getCurrentUserProfile(
          authToken: await authToken(context)
          );
          if(response is ErrorType){
            await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
            
          }else{
            //await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated');
                            print('Initial Profile Loaded');
                            print(ProfileModel.fromJson(response));
                            getProfileProvider(context).setProfileModel(
                            ProfileModel.fromJson(response));
            getProfileProvider(context).setInitialStatus(true);
          }
        } catch (error){
          print(error);
          await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(ErrorType.generic));
            
        }

      }

    launchCaller({@required String phone,@required BuildContext context}) async{
      String url = "tel:$phone";
      if(await canLaunch(url)){
        await launch(url);
      } else{
        PaysmosmoAlert.showSuccess(context: context, message: 'Could not place a call to $phone');
      }

    }


 Future loadGateManThatAccepted(context) async{
    try{
      dynamic response = await ResidentsGatemanRelatedService.getGateManThatAccepted(authToken: await authToken(context));
      if(response is ErrorType){
        PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
      } else {

        print(response);

        List<dynamic> responseData = response['data'];
        List<ResidentsGateManModel> models= [];
        responseData.forEach((jsonModel){
          models.add(ResidentsGateManModel.fromJson(jsonModel));
          
        });
        getResidentsGateManProvider(context).setResidentsGateManModels(models);
      }
    }catch(error){
      throw error;
    }
  }


 void loadInitialVisitors(BuildContext context) async {
                        
                                try {
                                
                                  dynamic response = await VisitorService.getAllVisitor(
                                      authToken: await authToken(context));
                                  if (response is ErrorType) {
                                    
                                    
                                     if(response == ErrorType.no_visitors_found){
                                      getVisitorProvider(context).setInitialStatus(true);
                                      PaysmosmoAlert.showError(
                                        context: context,
                                        message: GateManHelpers.errorTypeMap(response));
                                    }
                                    else{
                                      PaysmosmoAlert.showSuccess(
                                        context: context,
                                        message: GateManHelpers.errorTypeMap(response));
                                    }
                                     
                                        
                                  } else {
                                    if (response['data']['data'] == 0) {
                                      PaysmosmoAlert.showSuccess(
                                          context: context, message: 'No visitors');
                                    } else {
                                      print('linking data for visitors');
                                      print(response['data']['data']);
                                      dynamic jsonVisitorModels = response['data']['data'];
                                      List<VisitorModel> models = [];
                                      jsonVisitorModels.forEach((jsonModel) {
                                        models.add(VisitorModel.fromJson(jsonModel));
                                      });
                                      getVisitorProvider(context).setVisitorModels(models);

                                    
                                    }
                                  }
                                } catch (error) {
                                  throw error;
                                }
                            
                                }
                        
//UserType enum
enum user_type { ADMIN, GATEMAN, RESIDENT }
