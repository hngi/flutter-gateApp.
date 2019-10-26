import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';

class GateManVisitorProvider extends ChangeNotifier{

  RealVisitorModel visitorModel = RealVisitorModel();
  bool isLoaded = false;

  void setVisitorsList(RealVisitorModel visitor){
    print('displaying incoming visitors');
    this.visitorModel = visitor;
    this.isLoaded = true;
    notifyListeners();
  }
}

class RealVisitorModel {
  int visitors;
  List<RealVisitor> visitor;
  bool status;

  RealVisitorModel({
    this.visitors,
    this.visitor,
    this.status,
  });

  factory RealVisitorModel.fromJson(Map<String, dynamic> json) => RealVisitorModel(
    visitors: json["visitors"],
    visitor: List<RealVisitor>.from(json["visitor"].map((x) => RealVisitor.fromJson(x))),
    status: json["status"],
  );
}

class RealVisitor {
  int id;
  String name;
  DateTime arrivalDate;
  String carPlateNo;
  String purpose;
  String image;
  String status;
  dynamic timeIn;
  dynamic timeOut;
  int userId;
  dynamic qrCode;
  ResidentsGateManModel user;

  RealVisitor({
    this.id,
    this.name,
    this.arrivalDate,
    this.carPlateNo,
    this.purpose,
    this.image,
    this.status,
    this.timeIn,
    this.timeOut,
    this.userId,
    this.qrCode,
    this.user,
  });

  factory RealVisitor.fromJson(Map<String, dynamic> json) => RealVisitor(
    id: json["id"],
    name: json["name"],
    arrivalDate: DateTime.parse(json["arrival_date"]),
    carPlateNo: json["car_plate_no"],
    purpose: json["purpose"],
    image: json["image"],
    status: json["status"],
    timeIn: json["time_in"],
    timeOut: json["time_out"],
    userId: json["user_id"],
    qrCode: json["qr_code"],
    user: ResidentsGateManModel.fromJson(json["user"]),
  );
}
