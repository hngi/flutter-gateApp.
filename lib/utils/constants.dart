import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xgateapp/core/models/estate.dart';
import 'package:xgateapp/core/models/notification/resident_notification_model.dart';
import 'package:xgateapp/core/service/fcm_token_service.dart';
import 'package:xgateapp/core/service/notification_service/resident_notification_service.dart';
import 'package:xgateapp/core/models/gateman_residents_request.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/core/service/profile_service.dart';
import 'package:xgateapp/core/service/resident_service.dart';
import 'package:xgateapp/core/service/visitor_sevice.dart';
import 'package:xgateapp/providers/fcm_token_provider.dart';
import 'package:xgateapp/providers/profile_provider.dart';
import 'package:xgateapp/providers/requestProvider.dart';
import 'package:xgateapp/providers/resident_gateman_provider.dart';
import 'package:xgateapp/providers/resident_notificaton_provider.dart';
import 'package:xgateapp/providers/token_provider.dart';
import 'package:xgateapp/providers/user_provider.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';

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

RequestProvider getRequestProvider(BuildContext context){
  return Provider.of<RequestProvider>(context);
}

ResidentsGateManProvider getResidentsGateManProvider(BuildContext context) {
  return Provider.of<ResidentsGateManProvider>(context);
}


Future loadInitialProfile(BuildContext context,{bool showAlert = false}) async {
    print('Loading initial profile');
    getProfileProvider(context).setLoadingState(true);
        try{
        dynamic response  = await ProfileService.getCurrentUserProfile(
          authToken: await authToken(context)
          );
          if(response is ErrorType){
            if (showAlert){
              PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
            }
            
            
          }else{
            //await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated')
            print(':::::::::::::::::::::\n::::::::::::::::::::::::::::::::::\::::::::::::::::::::::;;;;');
            print(response);
                            print('Initial Profile Loaded');
                            print(ProfileModel.fromJson(response));
                            getProfileProvider(context).setProfileModel(
                            ProfileModel.fromJson(response),jsonString: json.encode(response));
          }

        getProfileProvider(context).setLoadingState(false);
        } catch (error){
          print(error);
          getProfileProvider(context).setLoadingState(false);  
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

Future loadGateManThatAccepted(context, {bool showAlert = false}) async {
  getResidentsGateManProvider(context).setAcceptedLoadingState(true);
  try {
    dynamic response =
        await ResidentsGatemanRelatedService.getGateManThatAccepted(
            authToken: await authToken(context));
    if (response is ErrorType) {
      if (showAlert){
        PaysmosmoAlert.showError(
          context: context, message: GateManHelpers.errorTypeMap(response));
      }
      
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
    print(error);
  }
  getResidentsGateManProvider(context).setAcceptedLoadingState(false);
}

Future loadInitRequests(BuildContext context, {bool alertNotifier = false}) async {
  try{
    dynamic response = await GatemanService.getAllRequests(authToken: await authToken(context));
    print(response);
    while(response != ErrorType){
      if(response['residents'] == 0){
        if(alertNotifier){
          PaysmosmoAlert.showSuccess(context: context, message: 'No requests yet');
        }
        
        getRequestProvider(context).setRequestModels([]);
      } else {
        print(response['residents']);
        dynamic requests = response['residents'];
        List<GatemanResidentRequest> models = [];
        requests.forEach((model){
          models.add(GatemanResidentRequest.fromJson(model));
        });

        getRequestProvider(context).setRequestModels(models, jsonStr: json.encode(response['residents']));

        getUserTypeProvider(context).setFirstRunStatus(false, loggedOut: false);
      }
    }
  } catch (error){
    print(error);
  }
}

Future loadInitialVisitors(BuildContext context,{bool skipAlert = true}) async {
  getVisitorProvider(context).setLoadingState(true);
  try {
    dynamic response =
        await VisitorService.getAllVisitor(authToken: await authToken(context));
    if (response is ErrorType) {
      if (response == ErrorType.no_visitors_found) {
        getVisitorProvider(context).setInitialStatus(true);
        PaysmosmoAlert.showSuccess(
            context: context, message: GateManHelpers.errorTypeMap(response));
            getVisitorProvider(context).setVisitorModels([]);
      }else if(response == ErrorType.unauthorized){

      }
      else {
        PaysmosmoAlert.showError(
            context: context, message: GateManHelpers.errorTypeMap(response));
      }
    } else {
      if (response== null || (response.containsKey('visitor') && response['visitor'] == 0)) {
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
  getVisitorProvider(context).setLoadingState(false);
}

Future loadScheduledVisitors(BuildContext context)async{
  getVisitorProvider(context).setScheduledVisitorsLoadingState(true);

  dynamic response = await VisitorService.getAllScheduledVisitor(authToken: await authToken(context));
  print(response);
  if(response is ErrorType == false){
    //update visitors provider
    if (response.containsKey('scheduled') && response['scheduled'].length != 0){
      List<VisitorModel> models = [];
      response['scheduled'].forEach((jsonObject){
        if(jsonObject['visitor']!=null){
           models.add(VisitorModel.fromJson(jsonObject['visitor']));
        }
       
      }
      );

      getVisitorProvider(context).setScheduledVisitorFromApi(models,jsonString: json.encode(response['scheduled']));
      
    } else {
      getVisitorProvider(context).setScheduledVisitorFromApi([]);
    }
  } 
  getVisitorProvider(context).setScheduledVisitorsLoadingState(true);

}
Future loadResidentsVisitorHistory(BuildContext context)async{
  getVisitorProvider(context).setHistoryVisitorsLoadingState = true;

  dynamic response = await VisitorService.getResidentsVisitorHistory(authToken: await authToken(context));
  print('tttttttttttttttttttffffffffffffffff');
  print(response);
  if(response is ErrorType == false){
    //update visitors provider
    if (response.containsKey('visitor_details') && response['visitor_details'].length != 0){
      List<VisitorModel> models = [];
      response['visitor_details'].forEach((jsonObject){
        models.add(VisitorModel.fromJson(jsonObject['visitor']));
      }
      );

      getVisitorProvider(context).setHistoryVisitorFromApi(models,jsonString: json.encode(response['visitor_details']));
      
    } else {
      getVisitorProvider(context).setHistoryVisitorFromApi([]);
    }
  } 
  getVisitorProvider(context).setHistoryVisitorsLoadingState = true;

}

void logOut(context)async {
  LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
  dialog.show();
  setFCMTokenToEmpty(context).then((value){
    if(value){
      Provider.of<TokenProvider>(context).clearToken();
  Provider.of<UserTypeProvider>(context).setFirstRunStatus(false,loggedOut: true); 
  Provider.of<ProfileProvider>(context)
                                ..setProfileModel(ProfileModel(),clean:true)
                                ..setLoadedFromApi(false);
  Provider.of<VisitorProvider>(context)
                                ..setVisitorModels([])
                                ..setLoadedFromApi(false)
                                ..setScheduledVisitorFromApi([],fromApi:false)
                                ..setScheduledVisitorsLoadedFromApiStatus(false);
  Provider.of<ResidentsGateManProvider>(context).loadedFromApi = false;
  Provider.of<ResidentsGateManProvider>(context).clear();
  getFCMTokenProvider(context).clear();
       PaysmosmoAlert.showSuccess(context: context,message: 'Logout successful'); 
       Navigator.pushNamedAndRemoveUntil(context, '/user-type',(Route<dynamic> route) => false);
    } else{
       PaysmosmoAlert.showError(context: context,message: 'Logout not Succesful,Please try again'); 
    }
  });
  
  
  
  
  
         
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
  getResidentsGateManProvider(context).setPendingLoadingState(true);
    try{
      dynamic response = await ResidentsGatemanRelatedService.getGateManThatArePending(authToken: await authToken(context));
      if(response is ErrorType){
        // PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));
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
    getResidentsGateManProvider(context).setPendingLoadingState(false);
  }


ResidentNotificationProvider getResidentNotificationProvider(BuildContext context){
  return Provider.of<ResidentNotificationProvider>(context);
}

Future  loadResidentNotificationFromApi(BuildContext context)async{
  getResidentNotificationProvider(context).setLoadingState(true);
  dynamic response = await ResidentNotificationService.getAllNotifications(authToken: await authToken(context));
  print(response);
  if (response is ErrorType){
    print('Error');
  } else {
    dynamic data = response['data'];
    List<ResidentNotificationModel> visitorsNot = [];
    List<ResidentNotificationModel> inviteNot = [];

    data.forEach((json){
      if (json['type'].toString().contains('visitor')){
          visitorsNot.add(ResidentNotificationModel.fromJson(json: json));

      } else{
        inviteNot.add(ResidentNotificationModel.fromJson(json: json));
      }
        
      });
      if (inviteNot.isEmpty && visitorsNot.isEmpty){
        print('Empty Notification');
        getResidentNotificationProvider(context).setNotificationModels(forInviteModels: null,forVisitorModels: null);
        getResidentNotificationProvider(context).setLoadedFromApi(true);

      } else {
      getResidentNotificationProvider(context).setNotificationModels(forInviteModels: inviteNot,forVisitorModels: visitorsNot);
      }

    

  }
  getResidentNotificationProvider(context).setLoadingState(false);
  
}

FCMTokenProvider getFCMTokenProvider(BuildContext context){
  return Provider.of<FCMTokenProvider>(context);
}

void setFCMTokenInServer(BuildContext context)async{
  getFCMTokenProvider(context).setLoadingState(true);
  dynamic response = await FCMTokenService.editFCMToken(authToken: await authToken(context), fcmToken: getFCMTokenProvider(context).fcmToken);
  print('I am printing token response');
  print(response);
  if (response is ErrorType){
    print(response);
  } else {
    getFCMTokenProvider(context).setFCMTokenLoadedToServerStatus(true);

  }
  getFCMTokenProvider(context).setLoadingState(false);

}


Future<dynamic> deleteVisitors(BuildContext context,int visitorId,{@required String from,@required int index})async{
  print('::::::::starting deletion::::;;');
  LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
  dialog.show();
  dynamic response = await VisitorService.deleteScheduledVisitor(authToken: await authToken(context), visitorId: visitorId);
  print(response);
  if (response is ErrorType){
    await PaysmosmoAlert.showError(context: context,message: '${GateManHelpers.errorTypeMap(response)}\n Please Try again');
    Navigator.pop(context);
  }else{
    await PaysmosmoAlert.showSuccess(context: context,message: 'Visitor Deleted Succesfully');
    if(from == 'scheduled'){
    getVisitorProvider(context).removeVisitorFromScheduled(visitorId: visitorId,index:index);
    } else if (from == 'history'){

      getVisitorProvider(context).removeVisitorFromHistory(visitorId: visitorId,index: index);

    }
    Navigator.pop(context);

  }

}

Future<dynamic> 
scheduleVisit(BuildContext context,String visiting_period,int visitorId,String arrival_date,String fullName,ScreenshotController screenshotController)async{
  LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
  dialog.show();
  dynamic response = await VisitorService.scheduleAVisit(authToken: await authToken(context),visiting_period: visiting_period,visitorId: visitorId,
  arrival_date: arrival_date);
 
  if (response is ErrorType){ 
    print(response);
      if (response == ErrorType.visitior_has_not_checked_out){
        Navigator.pop(context);
      await PaysmosmoAlert.showWarning(context: context,message: GateManHelpers.errorTypeMap(response));
      
      }else{
        Navigator.pop(context);
        await PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));

  
      }
      
  }else{
    
       await PaysmosmoAlert.showSuccess(context: context,message: 'You have Succesfully Schedule a Visit');
       Navigator.pop(context);
        VisitorModel model = VisitorModel.fromJson(response['visitor']);
        getVisitorProvider(context).addVisitorModel(model);
        getVisitorProvider(context).addVisitorModelToScheduled(model);
       String _base64 =  response['qr_image_src'].toString().split(',')[1];
      openAlertBox(base64String: _base64, code: response['visitor']['qr_code']??'Nil', context: context, fullName: fullName, screenshotController: screenshotController);
      getVisitorProvider(context).setScheduledVisitorsLoadedFromApiStatus(false);
      getVisitorProvider(context).setLoadedFromApi(false);
     
  }
}


Future<dynamic> setFCMTokenToEmpty(BuildContext context) async {
  dynamic response = await FCMTokenService.editFCMToken(authToken: await authToken(context), fcmToken: '');
  print('::::::::::-trying to set fcm to empty:::::');
  print(response);
  if (response is ErrorType){
    return false;
  } else {
    
    return true;
  }
}

openAlertBox({@required String code,@required BuildContext context,@required String base64String,@required ScreenshotController screenshotController,@required String fullName}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Screenshot(
            controller: screenshotController,
                      child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.only(top: 0.0),
              titlePadding: EdgeInsets.only(top: 0),

              content: Container(
                //width: 300.0,
                child: Container(
                  color: GateManColors.primaryColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: GateManColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 15.0, bottom: 5),
                                child: Image.asset('assets/images/success.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text(
                                  'Visitor Scheduled successfully',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Send Invitation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF466446)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Visitor : ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4f4f4f)),
                                    ),
                                    Text(
                                      fullName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF4f4f4f)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Image.memory(base64.decode(base64String),width: 150,height: 150,filterQuality: FilterQuality.low,),
                                /*child: Image.network(
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAB6klEQVR4nO2b0WrDMAwA17D//+Swt1Dw5ukkETv07rFpbHNIKLHi13meXxLjWL2AJ6EsgLIAygIoC6AsgLIAygIoC6AsgLIAygIoC6AsgLIAygIoC/Cdu+04SpbH7dlrwOvSOMXkUnH2IEYWQFmAZBpeoJAe0yeSUJMpirNTjCyAsgDVNLyYBHmu+oy1bzJO++y/z9I10CegLEBbGuaYPGdGsu9mjCyAsgCL03CSa6ga3oORBVAWoC0N23MEvcrdk6FGFkBZgGoa1vc9/howsi/aPvscIwugLMBr7ZPehiVvgpEFUBagrW8YeZVDrcDivigaMIiRBVAWoL9hUey/t3c3rl/qWz1GFkBZgLb2faT6THIE1b5IHqF3zCBGFkBZgGQaRrIm13HIPZ1O+h2RcYIYWQBlAfp3SiPPh5E/j1OgkSMrpBhZAGUBHrBT2rVC3w1vRVmAXU5YFMtiblKKkQVQFmDxCYtcVyK3DKvhrSgLsN0Ji1xZvAcjC6AswL6fdk8ofhiQxsgCKAuw70Gn3Gc54yX7hmtQFmDxCYtINSymanGF7xhZAGUBdjlh0dW5KH488M/gxfs/CmUBFvcNn4WRBVAWQFkAZQGUBVAWQFkAZQGUBVAWQFkAZQGUBVAWQFkAZQGUBVAW4AetVgW+JxZo9QAAAABJRU5ErkJggg=='
                                ),*/
                                ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: RaisedButton(
                                  color: Color(0xFFffa700),
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 50.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      code,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Show this at the security gate',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF49A347)),
                              ),
                              GestureDetector(
                                onTap: (){
                                  shareInvite(screenshotController: screenshotController);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16,horizontal: 16
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(
                                            width: 1,
                                            style: BorderStyle.solid,
                                            color: GateManColors.primaryColor)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset('assets/images/share.png'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF49A347)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                ),
              ),
            ),
          );
        });
  }

    Future shareInvite({ScreenshotController screenshotController}) async{
    screenshotController.capture(
    pixelRatio: 1.5
);
    screenshotController.capture().then((File image)async {
    //Capture Done
    print('sharing');
    await Share.file('Estate Invite',
        'qr.png',
       image.readAsBytesSync(),
        'image/png',
        text: 'Show this at the security gate.');
}).catchError((onError) {
    print(onError);
});
  }
  


