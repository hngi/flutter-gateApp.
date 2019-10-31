import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/notification/resident_notification_model.dart';
import 'package:xgateapp/core/service/notification_service/resident_notification_service.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';

class ResidentsNotificationList extends StatefulWidget {
  final String name, time;

  String notificationId;

  ResidentNotificationModel model;

  ResidentsNotificationList({
    this.name,
    this.time,
    this.notificationId,
    this.model
  });
  @override
  _ResidentsNotificationListState createState() =>
      _ResidentsNotificationListState();
}

class _ResidentsNotificationListState extends State<ResidentsNotificationList> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(children: <Widget>[
        InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                ),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 6.0,
              left: 20.0,
            ),
            child: Text(
              widget.time,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ]),
      ]),
      Container(
        padding: EdgeInsets.only(left: 300.0),
        child: PopupMenuButton(
          onSelected: (value)async{
            if (value == "delete"){
  try{
                      LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                      dialog.show();
                    dynamic response = await ResidentNotificationService.deleteNotification(authToken: await authToken(context),notificationId: this.widget.notificationId);
                    print(response);
                    if (response is ErrorType){
                      await PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));
                   
                    } else {
                      await PaysmosmoAlert.showSuccess(context: context,message: 'Notification Deleted');
                          getResidentNotificationProvider(context).deleteNotification(model:this.widget.model);
                      
                      getResidentNotificationProvider(context).setLoadedFromApi(false);
                      
                    }
                    Navigator.pop(context);
                      } catch(error){
                        throw error;
                      }
            } else{
              
            }
                    
                    },
            offset: Offset(0, 100),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "delete",
                      child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text(
                      'Delete this notification',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  )),
                  PopupMenuItem(
                    value: "turn_off",
                    child: ListTile(
                      leading: Icon(Icons.notifications_off),
                      title: Text(
                        "Turn off",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Turn off this notification',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ]),
      )
    ]);
  }
}