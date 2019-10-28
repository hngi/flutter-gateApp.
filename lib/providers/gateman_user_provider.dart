import 'package:flutter/widgets.dart';
import 'package:xgateapp/core/models/old_user.dart';

class GatemanUserProvider extends ChangeNotifier {
  //nothing yet
  GatemanModel gatemanUser = GatemanModel();

  //String fullName;

  GatemanUserProvider();

  void setFullName({@required String fullName}) {
    gatemanUser.fullName = fullName;
    notifyListeners();
  }

String getFullName(){
    return (gatemanUser.fullName == null || gatemanUser.fullName.isEmpty)? 'Loading...' : gatemanUser.fullName;
}
}
