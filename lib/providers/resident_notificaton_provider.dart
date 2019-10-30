import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/notification/resident_notification_model.dart';

class ResidentNotificationProvider extends ChangeNotifier{
  List<ResidentNotificationModel> forVisitorModels;
  List<ResidentNotificationModel> forInviteModels;
  bool loadedFromApi = false;

  bool loading = false;

  void setLoadingState(bool stat){
    loading = stat;
    notifyListeners();
  }

  setLoadedFromApi(bool stat){
  loadedFromApi = stat;
  notifyListeners();
}

  void setNotificationModels({List<ResidentNotificationModel> forVisitorModels,List<ResidentNotificationModel> forInviteModels}){
    this.forVisitorModels = forVisitorModels??this.forVisitorModels;
    this.forInviteModels = forInviteModels??this.forInviteModels;
    loadedFromApi = true;
    notifyListeners();
  }

  void addNotification({@required ResidentNotificationModel model}){
    switch (model.forType) {
      case ForType.visitor:
        forVisitorModels.add(model);
        notifyListeners();
        break;

      case ForType.invite:
        forInviteModels.add(model);
        notifyListeners();
        break;
      default:
      break;
    }

  }

  void deleteNotification({@required ResidentNotificationModel model}){
    switch (model.forType) {
      case ForType.visitor:
        forVisitorModels.removeAt(forVisitorModels.indexOf(model));
        notifyListeners();
        break;

      case ForType.invite:
        forInviteModels.removeAt(forInviteModels.indexOf(model));
        notifyListeners();
        break;
      default:
      break;
    }

  }









}