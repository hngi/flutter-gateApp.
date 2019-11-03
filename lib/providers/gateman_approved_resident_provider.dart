import 'package:flutter/cupertino.dart';
import 'package:xgateapp/core/models/gateman_residents_request.dart';
import 'package:xgateapp/core/models/request.dart';

class GatemanApprovedResidentProvider extends ChangeNotifier{
  List<Resident> residentList = [];

  bool loadedFromApi = false;
  bool loading =false;

  setResidentList(List<Resident> residentList){
    this.residentList = residentList;
    loadedFromApi = true;
    notifyListeners();

  }

  setLoading(bool stat){
    loading = stat;
  }

}