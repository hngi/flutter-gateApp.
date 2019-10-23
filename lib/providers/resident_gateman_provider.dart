import 'package:flutter/cupertino.dart';

class ResidentsGateManProvider extends ChangeNotifier {
  List<ResidentsGateManModel> residentsGManModels = [];
  List<ResidentsGateManModel> residentsGManModelsAwaiting = [];
    bool initialResidentsGateManLoaded = false;
  
    void addResidentsGateManModel(ResidentsGateManModel model){
      print('printing model from provider');
      print('model.toString()');
      this.residentsGManModels.add(model);
      notifyListeners();
    }

    void addResidentsGateManModels(List<ResidentsGateManModel> models){
      this.residentsGManModels.addAll(models);
      this.initialResidentsGateManLoaded = true;
      notifyListeners();
    }

    void setResidentsGateManModels(List<ResidentsGateManModel> models){
      this.residentsGManModels = models;
      this.initialResidentsGateManLoaded = true;
      notifyListeners();
    }

    void deleteResidentsGateManFromAccepted(ResidentsGateManModel model){
      print('deleting');
      int index = this.residentsGManModels.indexOf(model);
      this.residentsGManModels.removeAt(index);
      notifyListeners();
    }

    void deleteResidentsGateManFromPending(ResidentsGateManModel model){
      int index = this.residentsGManModelsAwaiting.indexOf(model);
      this.residentsGManModels.removeAt(index);
      notifyListeners();
    }

    void addAwaitingResidentsGateManModel(ResidentsGateManModel model){
      print('printing model from provider');
      this.residentsGManModelsAwaiting.add(model);
      notifyListeners();
    }
     void addAwaitingResidentsGateManModels(List<ResidentsGateManModel> models){
      this.residentsGManModels.addAll(models);
      this.initialResidentsGateManLoaded = true;
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