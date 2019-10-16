// Generated by https://quicktype.io

class Estate {
  int estateId;
  String estateName;
  String city;
  String country;

  Estate({
    this.estateId,
    this.estateName,
    this.city,
    this.country,
  });

  factory Estate.fromJson(Map<String, dynamic> json) {
    return Estate(
      estateId: json['estate_id'],
      estateName: json['estate_name'],
      city: json['city'],
      country: json['country'],
    );
  }
}