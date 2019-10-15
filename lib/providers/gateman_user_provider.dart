import 'package:flutter/widgets.dart';
import 'package:gateapp/core/models/old_user.dart';

class GatemanUserProvider extends ChangeNotifier {
  //nothing yet
  GatemanModel gatemanUser = GatemanModel();

  GatemanUserProvider();

  void setFullName({@required String fullName}) {
    gatemanUser.fullName = fullName;
    notifyListeners();
  }
}
