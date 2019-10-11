

import 'package:flutter/foundation.dart';
import 'package:gateapp/core/models/user.dart';

class AllEstateModel extends ChangeNotifier{
  List<EstateModel> estates= [];

  void addEstate(EstateModel estateModel){
    estates.add(estateModel);
    notifyListeners();
  }
}