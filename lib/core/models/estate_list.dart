import 'package:flutter/foundation.dart';
import 'package:gateapp/core/models/old_user.dart';

class AllEstateModel extends ChangeNotifier {
  List<EstateModel> estates = [
    EstateModel(
        city: "City1",
        country: 'Country1',
        estateAddress: 'Estate1',
        estateName: 'Peace Estate'),
    EstateModel(
        city: "City1",
        country: 'Country1',
        estateAddress: 'Estate1',
        estateName: 'Harmony Estate'),
    EstateModel(
        city: "City1",
        country: 'Country1',
        estateAddress: 'Estate1',
        estateName: 'Balance Estate')
  ];

  void addEstate(EstateModel estateModel) {
    estates.insert(0, estateModel);
    notifyListeners();
  }
}
