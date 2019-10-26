import 'package:gateapp/core/models/user.dart';

class GatemanResidentVisitors {
  int id;
  String name;
  String arrivalDate;
  String carPlateNo;
  String phoneNo;
  String purpose;
  String image;
  int status;
  dynamic timeIn;
  dynamic timeOut;
  int userId;
  String qrCode;
  String visitingPeriod;
  String description;
  String createdAt;
  String updatedAt;
  User user;

  GatemanResidentVisitors({
    this.id,
    this.name,
    this.arrivalDate,
    this.carPlateNo,
    this.phoneNo,
    this.purpose,
    this.image,
    this.status,
    this.timeIn,
    this.timeOut,
    this.userId,
    this.qrCode,
    this.visitingPeriod,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory GatemanResidentVisitors.fromJson(Map<String, dynamic> json) {
    return GatemanResidentVisitors(
      arrivalDate: json['arrival_date'],
      carPlateNo: json['car_plate_no'],
      createdAt: json['created_at'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      phoneNo: json['phone_no'],
      purpose: json['purpose'],
      qrCode: json['qr_code'],
      status: json['status'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      userId: json['user_id'],
      visitingPeriod: json['visiting_period'],
    );
  }
}