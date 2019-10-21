import 'package:flutter/cupertino.dart';
//import 'package:gateapp/core/models/old_user.dart';

class VisitorProvider extends ChangeNotifier {
  List<VisitorModel> visitorModels = [];
    bool initialVisitorsLoaded = false;
  
    void addVisitorModel(VisitorModel model){
      print('printing model from provider');
      print('model.toString()');
      this.visitorModels.add(model);
      notifyListeners();
    }

    void addVisitorModels(List<VisitorModel> models){
      this.visitorModels.addAll(models);
      this.initialVisitorsLoaded = true;
      notifyListeners();
    }
    void setVisitorModels(List<VisitorModel> models){
      this.visitorModels = models;
      this.initialVisitorsLoaded = true;
      notifyListeners();
    }


  
    void setInitialStatus(bool status){
      initialVisitorsLoaded = status;
      notifyListeners();
    }
  }
  
  class VisitorModel {
    int id,user_id,home_id, status;
    String name,arrival_date,car_plate_no,purpose,image,time_in,time_out;

    VisitorModel({
      this.id,this.name,this.arrival_date,this.car_plate_no,this.purpose,
      this.image,this.status,this.time_in,this.time_out,this.user_id,
      this.home_id
    });

  factory VisitorModel.fromJson(dynamic jsonModel){
    return VisitorModel(
      id:jsonModel['id'],
      name: jsonModel['name'],
      arrival_date: jsonModel['arrival_date'],
      car_plate_no: jsonModel['car_plate_no'],
      purpose: jsonModel['purpose'],
      image: jsonModel['image'],
      status: jsonModel['status'],
      time_in: jsonModel['time_in'],
      time_out: jsonModel['time_out'],
      user_id: jsonModel['user_id'],
      home_id: jsonModel['home_id']



    );
  
  
  }





}