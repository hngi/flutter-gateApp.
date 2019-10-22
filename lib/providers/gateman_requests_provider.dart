import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:gateapp/providers/resident_gateman_provider.dart';

class GateManRequestProvider  extends ChangeNotifier{

  RequestModel requestModel = RequestModel();


  /*@override
  String toString() {
    return 'GateManRequestProvider{requestModel: $requestModel}';
  }*/

  void addResident(RequestModel request){
    print('printing model from provider');
    print('model.toString()');
    this.requestModel = request;
    //notifyListeners();
  }

}

class RequestModel{
  int requests = 0;
  List<ResidentsGateManModel> residents = [];
  bool status = false;

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

