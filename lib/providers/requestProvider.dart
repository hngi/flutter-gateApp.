import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xgateapp/core/models/gateman_residents_request.dart';

class RequestProvider extends ChangeNotifier {

  List<GatemanResidentRequest> requestList = [];
  bool initialRequestsLoaded = false;
  //bool isLoadingFromApi = false;
  //bool isLoadingFromPrefs = false;
  bool isLoadedFromApi = false;
  bool isLoadedFromPrefs = false;

  void setFirstRunStatus(bool status){
    initialRequestsLoaded = status;
  }

  void setLoadedFromApi(bool status){
    isLoadedFromApi = status;
  }

  void setRequestModels(List<GatemanResidentRequest> models, {String jsonStr}) async {
    this.requestList = models;
    this.isLoadedFromApi = true;
    //String jsonStr = json.decode(models.toString());
    while(jsonStr != null){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('residents', jsonStr);
      //print(preferences.get('requests'));
    }
  }

  void setRequestsFromPrefs() async {
    if(!this.isLoadedFromApi && !this.isLoadedFromPrefs && this.requestList.isEmpty){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if(preferences.get('residents') != null){
        dynamic jsonList = json.decode(preferences.get('residents'));
        print(jsonList);
        jsonList.forEach((obj){
          requestList.add(GatemanResidentRequest.fromJson(obj));
        });
        isLoadedFromPrefs = true;
        return;
      }
    }
    return;
  }
}