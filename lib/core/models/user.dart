import 'package:flutter/material.dart';

class Model {
  String estateName;
  String estateAddress;
  String city;
  String country;

  Model({this.estateName, this.estateAddress, this.city, this.country});
}

enum user_type{
  GATEMAN,RESIDENT
}