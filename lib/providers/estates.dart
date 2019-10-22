// To parse this JSON data, do
//
//     final estates = estatesFromJson(jsonString);

//import 'dart:convert';
/*
class Estates {
  String message;
  List<Estate> estates;

  Estates({
    this.message,
    this.estates,
  });

  factory Estates.fromJson(String str) => Estates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Estates.fromMap(Map<String, dynamic> json) => Estates(
    message: json["message"] == null ? null : json["message"],
    estates: json["Estates"] == null ? null : List<Estate>.from(json["Estates"].map((x) => Estate.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
    "Estates": estates == null ? null : List<dynamic>.from(estates.map((x) => x.toMap())),
  };
}

class Estate {
  String estateName;
  String city;
  String country;

  Estate({
    this.estateName,
    this.city,
    this.country,
  });

  factory Estate.fromJson(String str) => Estate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Estate.fromMap(Map<String, dynamic> json) => Estate(
    estateName: json["estate_name"] == null ? null : json["estate_name"],
    city: json["city"] == null ? null : json["city"],
    country: json["country"] == null ? null : json["country"],
  );

  Map<String, dynamic> toMap() => {
    "estate_name": estateName == null ? null : estateName,
    "city": city == null ? null : city,
    "country": country == null ? null : country,
  };
}
*/
