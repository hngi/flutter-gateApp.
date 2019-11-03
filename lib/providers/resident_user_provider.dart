// import 'package:flutter/widgets.dart';
// import 'package:xgateapp/core/models/old_user.dart';

// class ResidentUserProvider extends ChangeNotifier {
//   //nothing yet
//   ResidentUserModel residentUserModel = ResidentUserModel();
  
//   ResidentUserProvider();

//   void setResidentEstate({@required EstateModel residentEstate}){
//     print("rrrrrrrrrrrrrrrr"+residentEstate.estateAddress);
//     residentUserModel.residentEstate = residentEstate;
//     notifyListeners();
//   }

//   void setResidentFullName({@required String residentFullName}){
//     residentUserModel.residentFullName = residentFullName;
//     notifyListeners();
//   }

//   void setResidentEmail({@required String residentEmail}){
//     residentUserModel.residentEmail = residentEmail;
//     notifyListeners();
//   }

//   void setResidentPhoneNumber({@required String residentPhoneNumber}){
//     residentUserModel.residentPhoneNumber = residentPhoneNumber;
//     notifyListeners();
//   }

//   void addGateMan({@required GatemanModel gatemanModel}){
//     residentUserModel.gatemans.add(gatemanModel);
//     notifyListeners();

//   }

//   void removeGateMan({@required GatemanModel gatemanModel}){
//     var index =  residentUserModel.gatemans.indexOf(gatemanModel);
//     residentUserModel.gatemans.removeAt(index);
//     notifyListeners();
//   }

//   void setGateManStatus({@required GatemanModel gatemanModel,@required GateManStatus gateManStatus}){
//     var index =  residentUserModel.gatemans.indexOf(gatemanModel);
//     residentUserModel.gatemans.elementAt(index).gateManStatus = gateManStatus;
//     notifyListeners();
//   }

//   void removeAlert({@required AlertModel alertModel}){
//     var index = residentUserModel.alerts.indexOf(alertModel);
//     residentUserModel.alerts.removeAt(index);
//     notifyListeners();
//   }



//   void addAlert({@required AlertModel alertModel}){
//     residentUserModel.alerts.add(alertModel);
//     notifyListeners();
//   }

//   void addVisitor({@required VisitorModel visitor}){
//     residentUserModel.visitors.add(visitor);
//     notifyListeners();
//   }
  
// }