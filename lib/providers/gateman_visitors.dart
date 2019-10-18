// To parse this JSON data, do
//
//     final gatemanVisitors = gatemanVisitorsFromJson(jsonString);

import 'dart:convert';

class GatemanVisitors {
  int visitors;
  List<Visitor> visitor;
  bool status;

  GatemanVisitors({
    this.visitors,
    this.visitor,
    this.status,
  });

  factory GatemanVisitors.fromJson(String str) => GatemanVisitors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GatemanVisitors.fromMap(Map<String, dynamic> json) => GatemanVisitors(
    visitors: json["visitors"] == null ? null : json["visitors"],
    visitor: json["visitor"] == null ? null : List<Visitor>.from(json["visitor"].map((x) => Visitor.fromMap(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "visitors": visitors == null ? null : visitors,
    "visitor": visitor == null ? null : List<dynamic>.from(visitor.map((x) => x.toMap())),
    "status": status == null ? null : status,
  };
}

class Visitor {
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
  User user;

  Visitor({
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

  factory Visitor.fromJson(String str) => Visitor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Visitor.fromMap(Map<String, dynamic> json) => Visitor(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    arrivalDate: json["arrival_date"] == null ? null : DateTime.parse(json["arrival_date"]),
    carPlateNo: json["car_plate_no"] == null ? null : json["car_plate_no"],
    purpose: json["purpose"] == null ? null : json["purpose"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    timeIn: json["time_in"],
    timeOut: json["time_out"],
    userId: json["user_id"] == null ? null : json["user_id"],
    qrCode: json["qr_code"],
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "arrival_date": arrivalDate == null ? null : "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
    "car_plate_no": carPlateNo == null ? null : carPlateNo,
    "purpose": purpose == null ? null : purpose,
    "image": image == null ? null : image,
    "status": status == null ? null : status,
    "time_in": timeIn,
    "time_out": timeOut,
    "user_id": userId == null ? null : userId,
    "qr_code": qrCode,
    "user": user == null ? null : user.toMap(),
  };
}

class User {
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

  User({
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
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    username: json["username"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    image: json["image"] == null ? null : json["image"],
    userType: json["user_type"] == null ? null : json["user_type"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "username": username,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "image": image == null ? null : image,
    "user_type": userType == null ? null : userType,
    "device_id": deviceId == null ? null : deviceId,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
