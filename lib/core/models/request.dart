/*
// To parse this JSON data, do
//
//     final requests = requestsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Requests extends ChangeNotifier{
  int requests;
  List<List<Resident>> residents;
  bool status;

  bool initRequests = false;

  Requests({
    this.requests,
    this.residents,
    this.status,
  });

  void addRequestModel(Resident resident){
    List<Resident> residents;
    print(resident.toString());
    residents.add(resident);
    notifyListeners();
  }

  void addRequestModels(List<Resident> residents){
    this.residents.forEach((residents)=> this.residents.add(residents));
    this.initRequests = true;
    notifyListeners();
  }

  void setRequestModel(List<List<Resident>> residentModels){
    this.residents = residentModels;
    this.initRequests = true;
    notifyListeners();
  }

  void setInitStatus(bool setStatus){
    initRequests = setStatus;
    notifyListeners();
  }

  factory Requests.fromRawJson(String str) => Requests.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Requests.fromJson(dynamic json) => Requests(
    requests: json["requests"],
    residents: List<List<Resident>>.from(json["residents"].map((x) => List<Resident>.from(x.map((x) => Resident.fromJson(x))))),
    status: json["status"],
  );

  dynamic toJson() => {
    "requests": requests,
    "residents": List<dynamic>.from(residents.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "status": status,
  };
}

class Resident {
  int id;
  String name;
  dynamic username;
  String phone;
  String email;
  String image;
  String userType;
  String deviceId;
  DateTime createdAt;
  DateTime updatedAt;
  int requestId;
  int requestStatus;
  int userId;
  int gatemanId;

  Resident({
    this.id,
    this.name,
    this.username,
    this.phone,
    this.email,
    this.image,
    this.userType,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
    this.requestId,
    this.requestStatus,
    this.userId,
    this.gatemanId,
  });

  factory Resident.fromRawJson(String str) => Resident.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Resident.fromJson(dynamic json) => Resident(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    userType: json["user_type"],
    deviceId: json["device_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    requestId: json["request_id"],
    requestStatus: json["request_status"],
    userId: json["user_id"],
    gatemanId: json["gateman_id"],
  );

  dynamic toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "email": email,
    "image": image,
    "user_type": userType,
    "device_id": deviceId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "request_id": requestId,
    "request_status": requestStatus,
    "user_id": userId,
    "gateman_id": gatemanId,
  };

  @override
  String toString(){
    return this.id.toString() + this.name;

  }
}
*/
