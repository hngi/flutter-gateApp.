import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:gateapp/providers/resident_gateman_provider.dart';

class GateManRequestProvider  extends ChangeNotifier{

  RequestModel requestModel = RequestModel();
  bool requestLoaded = false;

  void setResident(RequestModel request){
    print('printing model from provider');
    print('model.toString()');
    this.requestModel = request;
    this.requestLoaded = true;
    notifyListeners();
  }
}

class RequestModel{
  int requests;
  List<ResidentsGateManModel> residents;
  bool status;

  RequestModel({
    this.requests,
    this.residents,
    this.status,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        requests: json["requests"],
        residents: List<ResidentsGateManModel>.from(json["residents"].map((x) => ResidentsGateManModel.fromJson(x))),
        status: json["status"]
    );
  }
}

