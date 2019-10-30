
import 'package:xgateapp/core/models/notification/notification_types.dart';

class ResidentNotificationModel{
  ForType forType;
  String id, type;
  Map<String,dynamic> notificationData;
  DateTime createdAt;

  ResidentNotificationModel(
    {
      this.id,this.type,this.notificationData, this.createdAt,this.forType
    }
  );

factory ResidentNotificationModel.fromJson({dynamic json}){
  return ResidentNotificationModel(
    id: json['id'],
    type: json['type'],
    forType: json['type'].toString().contains('visitor')?ForType.visitor:ForType.invite,
    notificationData: json['data'],
    createdAt: DateTime(int.parse(json['created_at'].split(' ')[0].split('-')[0]),
    int.parse(json['created_at'].split(' ')[0].split('-')[1]),
    int.parse(json['created_at'].split(' ')[0].split('-')[2]),
    int.parse(json['created_at'].split(' ')[1].split('-')[0]),
    int.parse(json['created_at'].split(' ')[1].split('-')[1]),
    int.parse(json['created_at'].split(' ')[1].split('-')[2]))
  );
}









}


enum ForType{
  visitor,invite
}