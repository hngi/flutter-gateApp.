import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/core/service/profile_service.dart';
import 'package:gateapp/core/service/resident_service.dart';
import 'package:gateapp/core/service/visitor_sevice.dart';
import 'package:gateapp/providers/gateman_requests_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';
import 'package:gateapp/providers/resident_visitor_provider.dart';
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

UserTypeProvider getUserTypeProvider(BuildContext context) {
  return Provider.of<UserTypeProvider>(context);
}

ProfileProvider getProfileProvider(BuildContext context) {
  return Provider.of<ProfileProvider>(context);
}

VisitorProvider getVisitorProvider(BuildContext context) {
  return Provider.of<VisitorProvider>(context);
}

GateManRequestProvider getRequestProvider(BuildContext context) {
  return Provider.of<GateManRequestProvider>(context);
}

GateManVisitorProvider getRealVisitorProvider(BuildContext context) {
  return Provider.of<GateManVisitorProvider>(context);
}

ResidentsGateManProvider getResidentsGateManProvider(BuildContext context) {
  return Provider.of<ResidentsGateManProvider>(context);
}

Future loadInitialProfile(BuildContext context) async {
  try {
    dynamic response = await ProfileService.getCurrentUserProfile(
        authToken: await authToken(context));
    if (response is ErrorType) {
      PaysmosmoAlert.showError(
          context: context, message: GateManHelpers.errorTypeMap(response));
    } else {
      //await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated');
      print('Initial Profile Loaded');
      print(ProfileModel.fromJson(response));
      getProfileProvider(context)
          .setProfileModel(ProfileModel.fromJson(response));
      getProfileProvider(context).setInitialStatus(true);
      getUserTypeProvider(context).setFirstRunStatus(false);
    }
  } catch (error) {
    print(error);
    await PaysmosmoAlert.showError(
        context: context,
        message: GateManHelpers.errorTypeMap(ErrorType.generic));
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

void loadInitialVisitors(BuildContext context) async {
  try {
    dynamic response =
        await VisitorService.getAllVisitor(authToken: await authToken(context));
    if (response is ErrorType) {
      if (response == ErrorType.no_visitors_found) {
        getVisitorProvider(context).setInitialStatus(true);
        PaysmosmoAlert.showSuccess(
            context: context, message: GateManHelpers.errorTypeMap(response));
      } else {
        PaysmosmoAlert.showError(
            context: context, message: GateManHelpers.errorTypeMap(response));
      }
    } else {
      if (response['data']['data'] == 0) {
        PaysmosmoAlert.showSuccess(context: context, message: 'No visitors');
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

Future loadInitialVisitorsNew(BuildContext context) async {
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
      if (response['visitor'].length == 0) {
        PaysmosmoAlert.showSuccess(context: context, message: 'No visitors');
      } else {
        print('linking data for visitors');
        print(response['visitor']);
        dynamic jsonVisitorModels = response['visitor'];
        List<VisitorModel> models = [];
        jsonVisitorModels.forEach((jsonModel) {
          models.add(VisitorModel.fromJson(jsonModel));
        });
        getVisitorProvider(context).setVisitorModels(models);
        getUserTypeProvider(context).setFirstRunStatus(false);
      }
    }
  } catch (error) {
    throw error;
  }
}

void logOut(context) {
  Provider.of<TokenProvider>(context).clearToken();
  Provider.of<UserTypeProvider>(context)
      .setFirstRunStatus(true, loggingoutStatus: true);
  Provider.of<ProfileProvider>(context).setProfileModel(ProfileModel());
  Provider.of<VisitorProvider>(context).setVisitorModels([]);
  Navigator.pushNamedAndRemoveUntil(
      context, '/register', (Route<dynamic> route) => false);

  PaysmosmoAlert.showSuccess(context: context, message: 'Logout successful');
}

//UserType enum
enum user_type { ADMIN, GATEMAN, RESIDENT }

Future getImage(Function(File img) action, ImageSource source) async {
  File img = await ImagePicker.pickImage(source: source);

  action(img);
}

ProfileModel setMenuModel(BuildContext context) {
  ProfileModel model = getProfileProvider(context).profileModel;
  return model;
}

Future loadRequests(BuildContext context) async {
  try {
    dynamic response = await GateManService.getAllRequests(
        authToken: await authToken(context));
    //print('got a response');
    print(response);
    if (response['data'] == null) {
      print('there are no requests');
      getRequestProvider(context).setResident(response['data']);

      PaysmosmoAlert.showSuccess(
          context: context, message: 'No requests at this time');
    } else {
    print('linking data from response');
    print(response['data']);
    dynamic requestModelJson = response['data'];
    print(requestModelJson);
    getRequestProvider(context).setResident(RequestModel.fromJson(response));
    }
  } catch (error) {
    throw error;
  }
}

Future loadVisitorsList(BuildContext context) async {
  try {
    dynamic response = await GateManService.getAllVisitors(
        authToken: await authToken(context));
    print('received a response');
    print(response);
    print('linking data..');
    getRealVisitorProvider(context)
        .setVisitorsList(RealVisitorModel.fromJson(response));
  } catch (error) {
    throw error;
  }
}
