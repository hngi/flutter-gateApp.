import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:xgateapp/core/models/old_user.dart';

class VisitorProvider extends ChangeNotifier {
  List<VisitorModel> visitorModels = [];
  bool initialVisitorsLoaded = false;
  bool loadedFromApi = false;
  bool loadedFromPrefs = false;
  bool loading = false;

  List<VisitorModel> scheduledVisitorModels = [];
  bool scheduledVisitorsLoadedFromApi = false;
  bool scheduledVisitorsLoading = false;
  bool scheduledVisitorsLoadedFromPrefs = false;

  List<VisitorModel> savedVisitorModels = [];
  bool savedLoadedFromPrefs = false;

  List<VisitorModel> historyVisitorModels = [];
  bool historyVisitorsLoadedFromApi = false;
  bool historyVisitorsLoading = false;
  bool historyVisitorsLoadedFromPrefs = false;

  setScheduledVisitorsLoadedFromApiStatus(bool stat){
      scheduledVisitorsLoadedFromApi = stat;
  }

  setScheduledVisitorsLoadingState(bool stat){
    scheduledVisitorsLoading = stat;
  }

  setScheduledVisitorFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('scheduled_visitors');
    if(jsonString!=null){
       List<VisitorModel> models = [];
      json.decode(jsonString).forEach((jsonObject){
        models.add(VisitorModel.fromJson(jsonObject['visitor']));
      });
      scheduledVisitorModels = models;
      scheduledVisitorsLoadedFromPrefs = true;

    }
    notifyListeners();
  }

  setScheduledVisitorFromApi(List<VisitorModel> models,{String jsonString,bool fromApi = true})async{
    scheduledVisitorModels = models;
    if (jsonString != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('scheduled_visitors', jsonString);
    }
    if(fromApi){
      scheduledVisitorsLoadedFromApi = true;
    }
    
    notifyListeners();
  }

  setSavedVisitorFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('saved_visitors');
    if(jsonString!=null){
      List<VisitorModel> models = [];
      json.decode(jsonString).forEach((jsonObject){
        models.add(VisitorModel.fromJson(jsonObject));
      });
      savedVisitorModels = models;
      savedLoadedFromPrefs = true;

    }
    notifyListeners();
  }
  Future<bool> addVisitorModelToSaved(VisitorModel model) async{
    bool shouldSave = savedVisitorModels.where((VisitorModel modelF)=>modelF.id == model.id).length > 0?false:true;
    print(':::::::\n::::::::\n\:::::::::::$shouldSave');
    if (shouldSave){
      savedVisitorModels.add(model);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_visitors', convertVisitorModelsToString(savedVisitorModels));
    notifyListeners();
    }
    return shouldSave;
     }
    removeVisitorModelFromSaved(VisitorModel model,int index)async{
      savedVisitorModels.removeAt(index);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('saved_visitors', convertVisitorModelsToString(savedVisitorModels));
      notifyListeners();
    }


    removeVisitorFromScheduled({@required int visitorId, @required int index}){
      scheduledVisitorModels.removeAt(index);
      scheduledVisitorsLoadedFromApi = false;
      notifyListeners();
    }

    removeVisitorFromHistory({@required int visitorId, @required int index}){
      historyVisitorModels.removeAt(index);
      historyVisitorsLoadedFromApi = false;
      notifyListeners();
    }
    
    
      void setLoadingState(bool stat){
        loading = stat;
        notifyListeners();
      }
    
      set setHistoryVisitorsLoadedFromApiStatus(bool stat){
          historyVisitorsLoadedFromApi = stat;
          notifyListeners();
      }
    
      set setHistoryVisitorsLoadingState(bool stat){
        historyVisitorsLoading = stat;
        notifyListeners();
      }
    
      setHistoryVisitorFromPrefs() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String jsonString = prefs.getString('history_visitors');
        if(jsonString!=null){
           List<VisitorModel> models = [];
          json.decode(jsonString).forEach((jsonObject){
            models.add(VisitorModel.fromJson(jsonObject['visitor']));
          });
    
          historyVisitorModels = models;
          historyVisitorsLoadedFromPrefs = true;
    
        }
        notifyListeners();
      }
    
       setHistoryVisitorFromApi(List<VisitorModel> models,{String jsonString})async{
        historyVisitorModels = models;
        if (jsonString != null){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('history_visitors', jsonString);
        }
        historyVisitorsLoadedFromApi = true;
        notifyListeners();
      }
    
      void addVisitorModelToScheduled(VisitorModel model){
        scheduledVisitorModels.add(model);
        notifyListeners();
      }
    
      Future<bool> addVisitorModel(VisitorModel model, {String jsonString,bool update =false}) async {
        bool returnable = true;
        if (update==true){
          VisitorModel tobeUpdatedModel = this.visitorModels.firstWhere((VisitorModel modelF)=>modelF.id == model.id,orElse: null);
          if (tobeUpdatedModel == null){
            returnable = false;
          } else {
            int index  = visitorModels.indexOf(tobeUpdatedModel);
            visitorModels[index] = model;
            returnable = true;
          }
        }else{
        print('printing model from provider');
        print('model.toString()');
        this.visitorModels.add(model);
        if (jsonString != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String newVisitorsString;
          print('What I have now');
          if (prefs.getString('visitors') != null){
            print(json.decode(prefs.getString('visitors')));
           newVisitorsString = json.encode(json.decode(prefs.getString('visitors')).add(json.decode(jsonString)));
          } else {
            newVisitorsString = '[$jsonString]';
          }
          prefs.setString('visitors', newVisitorsString);
        }
        
        returnable = true;
      }
      notifyListeners();
      return returnable;
      
      }
    
      void setVisitorModelsFromPrefs() async {
        if (this.loadedFromApi == false &&
            this.loadedFromPrefs == false &&
            this.visitorModels.isEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(prefs.get('visitors'));
          if (prefs.get('visitors') != null) {
            print('Am not null joor');
            dynamic jsonList = json.decode(prefs.get('visitors'));
            print(jsonList);
            jsonList.forEach((jsonObject) {
              print(jsonObject);
                        visitorModels.add(VisitorModel.fromJson(jsonObject));
            });
            loadedFromPrefs = true;
            notifyListeners();
            return;
          }
        }
        return;
      }
    
      void addVisitorModels(
        List<VisitorModel> models,
      ) {
        this.visitorModels.addAll(models);
        this.initialVisitorsLoaded = true;
        notifyListeners();
      }
    
      void setLoadedFromApi(bool loaded){
      loadedFromApi = loaded;
      notifyListeners();
    }
    
      void setVisitorModels(List<VisitorModel> models, {String jsonString}) async {
        print('Loadddddddddedd from Api');
        this.visitorModels = models;
        this.loadedFromApi = true;
        if (jsonString != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('visitors', jsonString);
          print(prefs.get('visitors'));
        }
    
        notifyListeners();
      }
    
      void setInitialStatus(bool status) {
        initialVisitorsLoaded = status;
        notifyListeners();
      }
    
      String convertVisitorModelsToString(List<VisitorModel> savedVisitorModels) {
        List<Map<String,dynamic>> prefsStorable = [];
        savedVisitorModels.forEach((VisitorModel model){
          prefsStorable.add(model.toJson(model));
          });

          return json.encode(prefsStorable);

      }
}

class VisitorModel {
  int id, user_id, home_id, status;
  String name, arrival_date, car_plate_no, purpose,phone_no, image, time_in, time_out, visiting_period,visitor_group,qr_code;

  VisitorModel(
      {this.id,
      this.name,
      this.arrival_date,
      this.car_plate_no,
      this.purpose,
      this.phone_no,
      this.image,
      this.status,
      this.time_in,
      this.time_out,
      this.user_id,
      this.home_id,
      this.visiting_period,
      this.visitor_group,
      this.qr_code,
      });

  factory VisitorModel.fromJson(dynamic jsonModel) {
    return VisitorModel(
        id: jsonModel['id'],
        name: jsonModel['name'],
        arrival_date: jsonModel['arrival_date'],
        car_plate_no: jsonModel['car_plate_no'],
        purpose: jsonModel['purpose'],
        phone_no: jsonModel['phone_no'],
        image: jsonModel['image'],
        status: jsonModel['status'],
        time_in: jsonModel['time_in'],
        time_out: jsonModel['time_out'],
        user_id: jsonModel['user_id'],
        home_id: jsonModel['home_id'],
        visiting_period:jsonModel['visiting_period'],
        visitor_group: jsonModel['visitor_group'],
        qr_code: jsonModel.containsKey('qr_code')?jsonModel['qr_code']:null,

        );
  }

  Map<String,dynamic> toJson(VisitorModel model){
    return {
      'id':model.id??null,
      'name': model.name??'',
      'arrival_date': model.arrival_date??'',
      'car_plate_no': model.car_plate_no??'',
      'purpose': model.purpose??'',
      'phone_no': model.phone_no??'',
      'image': model.image??'',
      'status': model.status??null,
      'time_in': model.time_in??null,
      'time_out': model.time_out??null,
      'user_id': model.user_id??null,
      'home_id': model.home_id??null,
      'visiting_period': model.visiting_period??null,
      'visiting_group': model.visitor_group??'',
      'qr_code': model.qr_code??''



    };

  }
}
