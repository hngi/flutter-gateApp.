
import 'package:xgateapp/core/models/notification/notification_types.dart';

class ResidentNotificationModel{
  ForType forType;
  String id, type;
  Map<String,dynamic> notificationData;
  DateTime createdAt;
  bool read;

  ResidentNotificationModel(
    {
      this.id,this.type,this.notificationData, this.createdAt,this.forType,this.read
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
    int.parse(json['created_at'].split(' ')[1].split(':')[0]),
    int.parse(json['created_at'].split(' ')[1].split(':')[1]),
    int.parse(json['created_at'].split(' ')[1].split(':')[2])),
    read: json.containsKey('read_at') && json['read_at'] != null ? true:false

  );
}









}


enum ForType{
  visitor,invite
}