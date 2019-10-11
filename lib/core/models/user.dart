class Model {
  Model({this.estateName, this.estateAddress, this.city, this.country});

  String city;
  String country;
  String estateAddress;
  String estateName;
}

enum user_type { GATEMAN, RESIDENT }



class ResidentUserModel{
  EstateModel residentEstate;
  String residentFullName, residentPhoneNumber, residentEmail;
  List<GatemanModel> gatemans = [];
  List<AlertModel> alerts = [];
  List<VisitorModel> visitors = [];

  
  
  }
  
  class GatemanModel {
  String fullName, phoneNumber, email;
  EstateModel gatemanEstate;
  GateManStatus gateManStatus;

  GatemanModel({this.fullName,this.phoneNumber,this.email,this.gatemanEstate,this.gateManStatus});

  }
  
  enum GateManStatus {
    PENDING_CONFIRMATION, CONFIRMED, DECLINED
}

class GateManUserModel {
  EstateModel gatemanEstate;
  String gatemanFullName, gatemanPhoneNumber;
  List<ResidentModel> residents;
  List<AlertModel> alerts = [];
}

class AlertModel {}

class ResidentModel {
  String fullName, phoneNumber, email;
  EstateModel residentEstate;
  List<VisitorModel> visitors;
}

class VisitorModel {
  String visitorFullName, visitorPhoneNumber, visitorDescription;
  VisitorStatus visitorStatus;
  VerificationType verificationType;
}

enum VerificationType { QR_CODE, TEXT_CODE }

enum VisitorStatus { APPROVED, NOT_APPROVED }

class EstateModel {
  String country, city, estateAddress, estateName;
  EstateModel({this.country,this.city,this.estateAddress,this.estateName});
}
