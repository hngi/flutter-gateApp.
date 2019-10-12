

import 'package:flutter/foundation.dart';
import 'package:gateapp/core/models/user.dart';

class AllEstateModel extends ChangeNotifier{
  List<EstateModel> estates= [
    EstateModel(city: "City1",country: 'Country1',estateAddress: 'Estate1',estateName: 'ESteateName1')
  ];

  void addEstate(EstateModel estateModel){
    estates.add(estateModel);
    notifyListeners();
  }
}