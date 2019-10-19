// To parse this JSON data, do
//
//     final requests = requestsFromJson(jsonString);

import 'dart:convert';

class Requests {
  int requests;
  List<List<Resident>> residents;
  bool status;

  Requests({
    this.requests,
    this.residents,
    this.status,
  });

  factory Requests.fromJson(String str) => Requests.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Requests.fromMap(Map<String, dynamic> json) => Requests(
    requests: json["requests"] == null ? null : json["requests"],
    residents: json["residents"] == null ? null : List<List<Resident>>.from(json["residents"].map((x) => List<Resident>.from(x.map((x) => Resident.fromMap(x))))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "requests": requests == null ? null : requests,
    "residents": residents == null ? null : List<dynamic>.from(residents.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
    "status": status == null ? null : status,
  };
}

class Resident {
  int id;
  String name;

  Resident({
    this.id,
    this.name,
  });

  factory Resident.fromJson(String str) => Resident.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Resident.fromMap(Map<String, dynamic> json) => Resident(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
