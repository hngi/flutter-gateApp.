import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidentsGateManProvider extends ChangeNotifier {
  List<ResidentsGateManModel> residentsGManModels = [];
  List<ResidentsGateManModel> residentsGManModelsAwaiting = [];
    bool initialResidentsGateManLoaded = false;
    bool pendingloadedFromApi = false;
    bool pendingloadedFromPrefs = false;
    bool loadedFromApi = false;
    bool loadedFromPrefs = false;
    bool adding = false;

  

  bool loadingAccepted;

  bool loadingPending;

setAdding(bool ad){
  adding = ad;
  notifyListeners();
}

setAcceptedLoadingState(bool stat){
  loadingAccepted = stat;
  notifyListeners();
}

setPendingLoadingState(bool stat){
  loadingPending = stat;
  notifyListeners();
}

void clear(){
  pendingloadedFromApi = false;
  loadedFromApi = false;
  residentsGManModels = [];
  residentsGManModelsAwaiting = [];

}

setLoadedFromApi({bool stat,bool pendingStat}){
  loadedFromApi = stat??loadedFromApi;
  pendingloadedFromApi = pendingStat??pendingloadedFromApi;
  notifyListeners();
}
setLoadedFromApiForPending(bool stat){
  pendingloadedFromApi = stat;
  notifyListeners();
}

  bool initialResidentsGateManAwaitingLoaded =false;
  
    void addResidentsGateManModel(ResidentsGateManModel model,{String jsonString})async{
      print('printing model from provider');
      print('model.toString()');
      this.residentsGManModels.add(model);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(jsonString !=null){
      if(prefs.getString('resident_gateman')!=null){
        dynamic jsonObjects = json.decode(prefs.getString('resident_gateman'));
        jsonObjects.add(json.decode(jsonString));
        prefs.setString('resident_gateman',json.encode(jsonObjects));

      } else {
        prefs.setString('resident_gateman','[$jsonString]');
      }
      }
      
      notifyListeners();
    }

    void addResidentsGateManModels(List<ResidentsGateManModel> models,{String jsonString})async{
      this.residentsGManModels.addAll(models);
      this.initialResidentsGateManLoaded = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (jsonString !=null){
      if(prefs.getString('resident_gateman')!=null){
        dynamic jsonObjects = json.decode(prefs.getString('resident_gateman'));
        jsonObjects.add(json.decode(jsonString));
        prefs.setString('resident_gateman',json.encode(jsonObjects));

      } else {
        prefs.setString('resident_gateman',jsonString);
      }
      }
      
      notifyListeners();
    }

    void setResidentsGateManModels(List<ResidentsGateManModel> models,{String jsonString}) async{
      this.residentsGManModels = models;
      loadedFromApi = true;
      if(jsonString !=null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('resident_gateman',jsonString);
      }
      notifyListeners();
    }

    void setResidentsGateManModelsFromPrefs() async{
         SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.getString('resident_gateman')!=null){
          dynamic jsonObject  = json.decode(prefs.getString('resident_gateman'));
          List<ResidentsGateManModel> models = [];
          jsonObject.forEach((jsonObject){
                  models.add(ResidentsGateManModel.fromJson(jsonObject));
          });
          this.residentsGManModels = models;
        }
        notifyListeners();
    }

    void setResidentsGateManAwaitingModelsFromPrefs() async{
         SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.getString('resident_gateman_pending_acceptance')!=null){
          dynamic jsonObject  = json.decode(prefs.getString('resident_gateman_pending_acceptance'));
          List<ResidentsGateManModel> models = [];
          jsonObject.forEach((jsonObject){
                  models.add(ResidentsGateManModel.fromJson(jsonObject));
          });
          this.residentsGManModels = models;
        }
        notifyListeners();
    }

    void setResidentsGateManAwaitingModels(List<ResidentsGateManModel> models,{String jsonString})async {
      this.residentsGManModelsAwaiting = models;
      
      pendingloadedFromApi = true;
      if(jsonString !=null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('resident_gateman_pending_acceptance',jsonString);
      }

      notifyListeners();
    }

    void deleteResidentsGateManFromAccepted(ResidentsGateManModel model)async{
      print('deleting');
      int index = this.residentsGManModels.indexOf(model);
      this.residentsGManModels.removeAt(index);

      notifyListeners();
    }

    void deleteResidentsGateManFromPending(ResidentsGateManModel model)async {
      int index = this.residentsGManModelsAwaiting.indexOf(model);
      this.residentsGManModelsAwaiting.removeAt(index);
      notifyListeners();
    }

    void addAwaitingResidentsGateManModel(ResidentsGateManModel model,{String jsonString})async{
      print('printing model from provider');
      this.residentsGManModelsAwaiting.add(model);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(jsonString !=null){
      if(prefs.getString('resident_gateman_pending_acceptance')!=null){
        dynamic jsonObjects = json.decode(prefs.getString('resident_gateman_pending_acceptance'));
        jsonObjects.add(json.decode(jsonString));
        prefs.setString('resident_gateman_pending_acceptance',json.encode(jsonObjects));

      } else {
        prefs.setString('resident_gateman_pending_acceptance','[$jsonString]');
      }
      }
      notifyListeners();
    }
     void addAwaitingResidentsGateManModels(List<ResidentsGateManModel> models, {String jsonString})async{
      this.residentsGManModels.addAll(models);
      this.initialResidentsGateManLoaded = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(jsonString!=null){
      if(prefs.getString('resident_gateman_pending_acceptance')!=null){
        dynamic jsonObjects = json.decode(prefs.getString('resident_gateman_pending_acceptance'));
        jsonObjects.add(json.decode(jsonString));
        prefs.setString('resident_gateman_pending_acceptance',json.encode(jsonObjects));

      }else {
        prefs.setString('resident_gateman_pending_acceptance',jsonString);
      }
      }
      notifyListeners();
    }


  
    void setInitialStatus(bool status){
      initialResidentsGateManLoaded = status;
      notifyListeners();
    }
  }
  
  class ResidentsGateManModel {
    int id,user_id;
    String name,username,phone,email,image,status,created_at,updated_at;

    ResidentsGateManModel({
      this.id,this.name,this.user_id,this.username,this.phone,this.email,this.image,this.status,this.created_at,this.updated_at
    });

  factory ResidentsGateManModel.fromJson(dynamic jsonModel){
    print('the error is in conversion');
    return ResidentsGateManModel(
      id:jsonModel['id'],
      user_id: jsonModel['user_id'],
      name: jsonModel['name'],
      username: jsonModel['username'],
      phone: jsonModel['phone'],
      email: jsonModel['email'],
      image: jsonModel['image'],
      status: jsonModel['status'],
      created_at: jsonModel['created_at'],
      updated_at: jsonModel['updated_at']




    );
  
  
  }





}