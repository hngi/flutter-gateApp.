import 'dart:core';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/core/service/visitor_service_new.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:xgateapp/widgets/CustomDatePicker/custom_date_picker.dart';
import 'package:xgateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';
import 'package:xgateapp/widgets/VisitorsBox/VisitorsBox.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
class AddVisitorPart extends StatefulWidget {
  bool editMode = false;
   int visitorId;
  String initName,initArrivalDate,initArrivalPeriod,initCarPlateNumber,initPurpose,initVisitorsPhoneNo,initVisitorsImageLink,initialGroup,description;

  AddVisitorPart({this.editMode,this.initName,this.initArrivalDate,this.initArrivalPeriod,this.initCarPlateNumber,
  this.initPurpose,this.initVisitorsPhoneNo,this.initVisitorsImageLink,this.visitorId,this.initialGroup='none',this.description});
  @override
  _AddVisitorPartState createState() => _AddVisitorPartState();
}

class _AddVisitorPartState extends State<AddVisitorPart> with TickerProviderStateMixin  {
  bool showingMoreDetail = true;
  bool morningChecked=true;
  bool afternoonChecked=false;
  bool eveningChecked=false;
  String arrivalDate='';
  TextEditingController _arrivalDateController = TextEditingController();

  TextEditingController _fullNameController;
  TextEditingController _carPlateNumberController;
  TextEditingController _purposeController;
  TextEditingController _phoneController,_descriptionController;


  String _fullname;
  
  File imageFile;

  String _base64;

  ScreenshotController screenshotController;

  bool saveVisitor = false;

  String initialGroup = 'none';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController(text:this.widget.initName??'');
    _carPlateNumberController = TextEditingController(text:this.widget.initCarPlateNumber??'');
    _purposeController=TextEditingController(text: this.widget.initPurpose??'');
    _phoneController = TextEditingController(text: this.widget.initVisitorsPhoneNo??'');
    _descriptionController = TextEditingController(text: this.widget.description??'');
    screenshotController = ScreenshotController();
    if(this.widget.initArrivalPeriod != null){
      if(this.widget.initArrivalPeriod.toLowerCase() == 'afternoon'){
          this
            ..morningChecked = false
            ..afternoonChecked = true
            ..eveningChecked = false;
      } else if(this.widget.initArrivalPeriod.toLowerCase() == 'evening'){
          this
            ..morningChecked = false
            ..afternoonChecked = false
            ..eveningChecked = true;
      }
    }
    this.initialGroup = this.widget.initialGroup??'none';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _carPlateNumberController.dispose();
    _purposeController.dispose();
    _phoneController.dispose();

  }

  List<File> _images;

  File image;

  Future shareInvite() async{
    screenshotController.capture(
    pixelRatio: 1.5
);
    screenshotController.capture().then((File image)async {
    //Capture Done
    print('sharing');
    await Share.file('Estate Invite',
        'qr.png',
       image.readAsBytesSync(),
        'image/png',
        text: 'Show this at the security gate.');
}).catchError((onError) {
    print(onError);
});
  }

  

  void toggleShowingMoreDetail() {
    setState(() {
      showingMoreDetail = !showingMoreDetail;
    });
  }

  openAlertBox(String code) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Screenshot(
            controller: screenshotController,
                      child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.only(top: 0.0),
              titlePadding: EdgeInsets.only(top: 0),

              content: Container(
                //width: 300.0,
                child: Container(
                  color: GateManColors.primaryColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: GateManColors.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 15.0, bottom: 5),
                                child: Image.asset('assets/images/success.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text(
                                  'Visitor ${!this.widget.editMode?"added":"updated"} successfully',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Send Invitation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF466446)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Visitor : ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4f4f4f)),
                                    ),
                                    Text(
                                      _fullNameController.text,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF4f4f4f)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Image.memory(base64.decode(_base64),width: 150,height: 150,filterQuality: FilterQuality.low,),
                                /*child: Image.network(
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAB6klEQVR4nO2b0WrDMAwA17D//+Swt1Dw5ukkETv07rFpbHNIKLHi13meXxLjWL2AJ6EsgLIAygIoC6AsgLIAygIoC6AsgLIAygIoC6AsgLIAygIoC/Cdu+04SpbH7dlrwOvSOMXkUnH2IEYWQFmAZBpeoJAe0yeSUJMpirNTjCyAsgDVNLyYBHmu+oy1bzJO++y/z9I10CegLEBbGuaYPGdGsu9mjCyAsgCL03CSa6ga3oORBVAWoC0N23MEvcrdk6FGFkBZgGoa1vc9/howsi/aPvscIwugLMBr7ZPehiVvgpEFUBagrW8YeZVDrcDivigaMIiRBVAWoL9hUey/t3c3rl/qWz1GFkBZgLb2faT6THIE1b5IHqF3zCBGFkBZgGQaRrIm13HIPZ1O+h2RcYIYWQBlAfp3SiPPh5E/j1OgkSMrpBhZAGUBHrBT2rVC3w1vRVmAXU5YFMtiblKKkQVQFmDxCYtcVyK3DKvhrSgLsN0Ji1xZvAcjC6AswL6fdk8ofhiQxsgCKAuw70Gn3Gc54yX7hmtQFmDxCYtINSymanGF7xhZAGUBdjlh0dW5KH488M/gxfs/CmUBFvcNn4WRBVAWQFkAZQGUBVAWQFkAZQGUBVAWQFkAZQGUBVAWQFkAZQGUBVAW4AetVgW+JxZo9QAAAABJRU5ErkJggg=='
                                ),*/
                                ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: RaisedButton(
                                  color: Color(0xFFffa700),
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 50.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      code,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Show this at the security gate',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFF49A347)),
                              ),
                              GestureDetector(
                                onTap: (){
                                  shareInvite();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16,horizontal: 16
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(
                                            width: 1,
                                            style: BorderStyle.solid,
                                            color: GateManColors.primaryColor)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset('assets/images/share.png'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF49A347)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                ),
              ),
            ),
          );
        });
  }

  List<Widget> _moreDetail() {
    return [
     Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: Text(
          'Arrival Date',
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
      CustomDatePicker(
        dateController: _arrivalDateController,
        onChanged: (date){
          print('date as been changed to ' + date);
          _arrivalDateController.text = date;
          // arrivalDate=date;
        },
        onSaved: (date){
        _arrivalDateController.text = date;
        // arrivalDate=date;
        },
        now: DateTime.now(),minimumAllowedDate: DateTime.now(),
        includeInput: true,
        showingDetail: true,
        selectedDate: _arrivalDateController.text==DateTime.now().day.toString()+
        DateTime.now().month.toString()+
        DateTime.now().year.toString() ||_arrivalDateController.text==''?null:
        _arrivalDateController.text.split('/').map((f){
          return int.parse(f);
        }).toList(),
      ),
     Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(child: CustomCheckBox(text: 'Morning',checked: this.morningChecked,),
            onTap: (){setState(() {
             this.morningChecked = true;
             this.afternoonChecked = false;
             this.eveningChecked = false ;
            });},),
            InkWell(child: CustomCheckBox(text: 'Afternoon',checked: this.afternoonChecked,),
            onTap: (){
              setState(() {
                this.morningChecked = false;
                this.afternoonChecked = true;
                this.eveningChecked = false;
              });
            },),
            InkWell(child: CustomCheckBox(text: 'Evening',checked: this.eveningChecked,),
            onTap: (){
              setState(() {
               this.morningChecked = false;
               this.afternoonChecked = false;
               this.eveningChecked = true; 
              });
            },),
          ],
        ),
      ),
       Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
        child: Text(
          'Car Plate Number (Optional)',
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
      
      CustomInputField(
        hint: 'Enter car plate number',
        prefix: Image.asset('assets/images/Vector.png'),
        keyboardType: TextInputType.text,
        textEditingController: _carPlateNumberController,
      ),
      CustomDropdownButton(hintText: "Visitor's Group",
      label: "Visitor's Group",
      value: initialGroup??'none',onChanged: (f){
        setState(() {
         initialGroup = f; 
        });
      },
      items: ['none'
      ,'Families','Friends'].map((String f){
        return DropdownMenuItem(
          value: f,
          child: Text(f),
        );
      }).toList(),),
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
        child: Text(
          'Purpose',
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),

      CustomInputField(
        hint: 'Purpose',
        keyboardType: TextInputType.text,
        textEditingController: _purposeController, prefix: Icon(Icons.assignment_ind),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
        child: Text(
          "Visitor's Description",
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
      CustomInputField(
        hint: 'Description',
        keyboardType: TextInputType.text,
        textEditingController: _descriptionController, prefix: Icon(Icons.assignment_ind),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
        child: Text(
          "Visitor's phone number",
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),

      CustomInputField(
        hint: "Visitor's phone number",
        keyboardType: TextInputType.text,
        textEditingController: _phoneController, prefix: Icon(Icons.contact_phone),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 16),
        child: Text(
          'Visitor\'s Image (Optional)',
          style: TextStyle(
              color: GateManColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        height: 125,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: (){
            getImage((img){
              setState(() {
               image = img;
              });

            },ImageSource.gallery);
          },
          child: DashedRectangle(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image==null?this.widget.initVisitorsImageLink!=null?Image.network(Endpoint.imageBaseUrl+this.widget.initVisitorsImageLink,height: 102,width: 400):
                Image.asset('assets/images/ei-image.png'):Image.file(image,height: 102,width: 400,),
                Visibility(
                  visible: image==null,
                  child: Text(
                    'Upload Visitor\'s Image',
                    style: TextStyle(
                        color: Color(0xFF878787),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          
          onTap: (){

            setState(() {
             saveVisitor = !saveVisitor; 
            });
          },
                  child: CustomCheckBox(
                    checked: saveVisitor,
            text: 'Save Visitor',
            
          ),
        ),
      )

    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Kindly enter visitor\'s name below',
              style: TextStyle(
                  color: GateManColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputField(
              hint: 'Enter full name',
              prefix: Icon(Icons.person),
              keyboardType: TextInputType.text,
              textEditingController: _fullNameController,
              onSaved: (str) => _fullname = str,
              validator: (str) =>
                str.isEmpty ? 'Full name cannot be empty.' : null,
              enabled: !this.widget.editMode,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: AnimatedSize(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:_moreDetail()),
                duration: Duration(milliseconds: 1000), vsync: this,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ActionButton(
                buttonText: this.widget.editMode==true?'Update':'Add',
                onPressed: () async {
                  print(_arrivalDateController.text);
                  final date=_arrivalDateController.text.split('/').reversed.join('-');
                  
                  print(date);

                  print('FULL NAME '+_fullNameController.text);
                  print('CAR PLATE: '+_carPlateNumberController.text);
                  print('PURPOSE: '+_purposeController.text);
                  print('GROUP: '+ initialGroup);
                  print('PHONE: ' + _phoneController.text);
                  print('ARRIVAL DATE: $date');
                  print('IMAGE PATH: $image');
                  print(this.morningChecked?'morning':this.afternoonChecked?'afternoon':'Evening');


                  if(_fullNameController.text==""){
                    PaysmosmoAlert.showError(context: context,message: 'Full name field cannot be empty');


                  }else{
                    /*VisitorService.addVisitor(
                        name: _fullNameController.text, arrivalDate: DateFormat('MM-dd-yyyy').format(DateFormat().add_yMd().parse(arrivalDate)) as DateFormat,
                        carPlateNo: _carPlateNumberController.text, purpose: null,
                        status: null, estateId: null,//image: image==null?null:image.path.toString(),
                        //authToken: await authToken(context),
                    );*/
                    // openAlertBox();
                    if (this.widget.editMode == false || this.widget.editMode == null){
                                          LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                                          dialog.show();
                                          print(date);
                                          dynamic response = await NewVisitorService.addVisitor(
                                            name: _fullNameController.text,
                                            arrivalDate: date.isEmpty? DateFormat('yyyy-MM-dd').format(DateTime.now()):date,
                                            carPlateNo: _carPlateNumberController.text,
                                            purpose: _purposeController.text.isEmpty? 'none':_purposeController.text,
                                            phone: _phoneController.text.isEmpty?null:_phoneController.text,
                                            status: '8',
                                            estateId: '7',//image: image==null?null:image.path.toString(),
                                            authToken: await authToken(context),
                                            image: image??null,
                                            visitingPeriod: this.morningChecked?'morning':this.afternoonChecked?'afternoon':'Evening',
                                            visitorsGroup: initialGroup,
                                            description: _descriptionController.text
                                          );
                      
                                          print(response);
                                          if (response is ErrorType){
                                            Navigator.pop(context);
                      
                      
                                            PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));
                                          
                                          } else{
                                              // print(response);
                                              dialog.hide();
                                              VisitorModel model = VisitorModel.fromJson(response['visitor']);
                                              getVisitorProvider(context).addVisitorModel(model);
                                              if (saveVisitor){
                                                    if (await saveVisitorToPref(context,model) == false){
                                                      PaysmosmoAlert.showWarning(context: context,message: 'You already have this Visitor Saved');
                                                    } else{
                                                       PaysmosmoAlert.showSuccess(context: context,message: _fullNameController.text + ' as been added to your visitors list');
                                             
                                                    }
                                          }
                                             loadInitialVisitors(context,skipAlert:true);
                                             getVisitorProvider(context).addVisitorModelToScheduled(model);
                                             loadScheduledVisitors(context);
                                               PaysmosmoAlert.showSuccess(context: context,message: _fullNameController.text + ' as been updated');
                                             
                                              print("qt image");
                                              print(response['qr_image_src']);
                                              setState(() {
                                               _base64 =  response['qr_image_src'].toString().split(',')[1];
                                              });
                                              openAlertBox(response['visitor']['qr_code']??'Nil');
                                          }

                    } else {
                         LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                                          dialog.show();
                                          print(date);
                                          print('${this.widget.visitorId} ::::::::::');
                                          dynamic response = await NewVisitorService.updateVisitor(
                                            name: _fullNameController.text,
                                            arrivalDate: date.isEmpty? DateFormat('yyyy-MM-dd').format(DateTime.now()):date,
                                            carPlateNo: _carPlateNumberController.text,
                                            purpose: _purposeController.text.isEmpty? 'none':_purposeController.text,
                                            phone: _phoneController.text.isEmpty?null:_phoneController.text,
                                            status: '8',
                                            estateId: '7',//image: image==null?null:image.path.toString(),
                                            authToken: await authToken(context),
                                            image: image??null,
                                            visitingPeriod: this.morningChecked?'morning':this.afternoonChecked?'afternoon':'Evening',
                                            visitorsGroup: initialGroup, visitorId: this.widget.visitorId,
                                            description: _descriptionController.text
                                          );
                      
                                          print(response);
                                          if (response is ErrorType){
                                            Navigator.pop(context);
                      
                      
                                            PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));
                                          
                                          } else{
                                              // print(response);
                                              
                                              VisitorModel model = VisitorModel.fromJson(response['visitor']);
                                              if(await getVisitorProvider(context).addVisitorModel(model,update: true)){
                                                PaysmosmoAlert.showWarning(context: context,message: 'Visitor Updated Succesfully');
                                                   

                                              }else{

                                              }
                                              if (saveVisitor){
                                                    if (await saveVisitorToPref(context,model) == false){
                                                      PaysmosmoAlert.showWarning(context: context,message: 'You already have this Visitor Saved');
                                                    }
                                          }
                                             loadInitialVisitors(context,skipAlert:true);
                                             getVisitorProvider(context).addVisitorModelToScheduled(model);
                                             loadScheduledVisitors(context);
                                              
                                              PaysmosmoAlert.showSuccess(context: context,message: _fullNameController.text + ' as been added to your visitors list');
                                              print("qt image");
                                              print(response['qr_image_src']);
                                              print('${model.id} ::::::::id:::here');
                                              dynamic qr_image_src = await NewVisitorService.getQrImageSrcForVisitor(authToken: await authToken(context), visitorId: model.id);

                                              if (qr_image_src is ErrorType){
                                                await PaysmosmoAlert.showError(context: context,message: '${GateManHelpers.errorTypeMap(qr_image_src)}\ncould not retrieve qr image');
                                                Navigator.pop(context);
                                              } else{
                                                Navigator.pop(context);
                                                setState(() {
                                               _base64 =  qr_image_src['qr_image'].toString().split(',')[1];
                                              });
                                              openAlertBox(qr_image_src['qr_code']??'Nil');
                                              }
                                              
                                          }

                    }
                    
                                          
                      
                                          
                                        }
                      
                                      },
                                      horizontalPadding: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  // Text(
                                  //   'Visitors',
                                  //   style: TextStyle(
                                  //       color: GateManColors.primaryColor,
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // VisitorsBox(
                                  //     visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
                                  // VisitorsBox(
                                  //     visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
                                  // VisitorsBox(
                                  //     visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
                                ],
                              ),
                            ),
                          );
                        }
                      
                        Future<bool> saveVisitorToPref(BuildContext context,VisitorModel model) {
                          return getVisitorProvider(context).addVisitorModelToSaved(model);
                        }

}


