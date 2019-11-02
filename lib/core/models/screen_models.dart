import 'package:xgateapp/providers/visitor_provider.dart';

class AddEditVisitorScreenModel{
bool editMode;
int visitorId;

  String initArrivalDate,initName,initArrivalPeriod,initCarPlateNumber,initPurpose,initVisitorsPhoneNo,initVisitorsImageLink,visitorGroup;

AddEditVisitorScreenModel({
  this.editMode,this.initName,this.initArrivalDate,this.initArrivalPeriod,this.initCarPlateNumber,
  this.initPurpose,this.initVisitorsPhoneNo,this.initVisitorsImageLink,this.visitorGroup,
  this.visitorId
});

factory AddEditVisitorScreenModel.fromVisitorModel(VisitorModel model){
  print('visitors id is right here::::::::::::::::::::::::::::${model.id}');
  return AddEditVisitorScreenModel(editMode: 
  true,
  initName: model.name??'',
  initArrivalDate: model.arrival_date??'',
  initArrivalPeriod: model.visiting_period??'',
  initCarPlateNumber: model.car_plate_no??'',
  initPurpose: model.purpose??'',
  initVisitorsImageLink: model.image=='noimage.jpg'||model.image == 'no_image.jpg' || model.image == null?null:model.image,
  initVisitorsPhoneNo: model.phone_no??'',
  visitorGroup: model.visitor_group??'none',
  visitorId: model.id
  
  );
}

}