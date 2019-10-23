class ResidentsModel {
  int residentId;
  String fullName;
  String address;
  String phoneNumber;

  ResidentsModel({
    this.residentId,
    this.fullName,
    this.address,
    this.phoneNumber,
  });

  factory ResidentsModel.fromJson(Map<String, dynamic> json){
    return ResidentsModel(
      residentId: json['id'],
      fullName: json['fullName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
