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
import 'package:qr_flutter/qr_flutter.dart';
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
  bool showingMoreDetail = false;
  bool morningChecked=true;
  bool afternoonChecked=false;
  bool eveningChecked=false;
  String arrivalDate='';
  TextEditingController _arrivalDateController = TextEditingController();

  TextEditingController _fullNameController;
  TextEditingController _carPlateNumberController;
  TextEditingController _purposeController;
  TextEditingController _phoneController,_descriptionController;

  static const List<String> months = ['January','Feburary','March','April','May','June','July',
  'August','September','October','November','December'];

   List<String> weeks = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  String _fullname;
  
  File imageFile;

  String _base64;

  ScreenshotController screenshotController;

  bool saveVisitor = false;

  String initialGroup = 'None';

  List<dynamic> selectedDate;

  List<bool> calendarOptionsDisplaying = [true,false,false];


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
    this.initialGroup = this.widget.initialGroup??'None';
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
        text: 'Kindly share this with your visitor and inform them to show the security at the gate.');
}).catchError((onError) {
    print(onError);
});
  }

  

  void toggleShowingMoreDetail() {
    setState(() {
      showingMoreDetail = !showingMoreDetail;
    });
  }
toggleCalendarOptions(int index){
  if (index == 2){
    setState(() {
      calendarOptionsDisplaying = [false,false,true];
    });
    return ;
  }
  
  setState(() {
    int ind = -1;
                          calendarOptionsDisplaying = calendarOptionsDisplaying.map((f){
                            ind +=1;
                            if(ind == index){
                              return true;
                            } else {
                             
                                return !calendarOptionsDisplaying[ind];
                            }
                          }).toList();
                          print(calendarOptionsDisplaying);
                        });
}

  List<Widget> _moreDetail() {
    return [
      
     
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
        prefix: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10),
          child: ImageIcon(AssetImage('assets/images/icons/car_plate_number_icon.png'),size: 14,),
        ),
        keyboardType: TextInputType.text,
        textEditingController: _carPlateNumberController,
      ),
      CustomDropdownButton(hintText: "Visitor's Group",
      label: "Visitor's Group",
      value: initialGroup??'None',onChanged: (f){
        setState(() {
         initialGroup = f; 
        });
      },
      items: ['None'
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
             Padding(
               padding: const EdgeInsets.only(bottom:8.0),
               child: Text(
                'Arrival Date',
                style: TextStyle(
                    color: GateManColors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
            ),
             ),
             

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: GateManColors.grayColor)
              ),
              child: Column(
                children: [
                  calendarOptionsDisplaying[0]?
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0,top: 4),
                    child: buildCalendarOption(
                      iconImageSrc: 'assets/images/icons/calendar_today.png',
                      day: 'Today',
                      dayInString: weeks[DateTime.now().weekday-1],
                      onPressed: (){
                        toggleCalendarOptions(0);
                      }
                    ),
                  ):Container(width: 0,height: 0,),
                  calendarOptionsDisplaying[1]?

                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0,top: 4),
                    child: buildCalendarOption(
                       iconImageSrc: 'assets/images/icons/calendar_tomorrow.png',
                      day: 'Tomorrow',
                      dayInString: weeks[DateTime.now().weekday > 6?0:DateTime.now().weekday],
                      onPressed: (){
                        toggleCalendarOptions(1);
                      }
                    ),
                  ):Container(width: 0,height: 0,),
                  calendarOptionsDisplaying[2]?
                  Padding(
                    padding: const EdgeInsets.only(bottom:4.0,top: 4),
                    child: buildCalendarOption(
                        day: selectedDate==null?'Set from calendar':'${ordinal_suffix_of(selectedDate[0])}, ${months[selectedDate[1]-1]} ${selectedDate[2]}',
                        dayInString: selectedDate!=null?weeks[DateTime(selectedDate[2],selectedDate[1],selectedDate[0]).weekday-1]:'',
                        onPressed: (){
                        Future.delayed(Duration.zero,_showCalendarDialog(context));
                        
                      },
                        iconImageSrc: 'assets/images/icons/set_from_calendar.png',
                                            ),
                                        ):Container(width: 0,height: 0,),
                                      ]
                                    ),
                      
                      
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
        padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
        child: InkWell(
          onTap: (){toggleShowingMoreDetail();},
          child:Row(
            children: <Widget>[
              Text('Advanced options',style:TextStyle(color: GateManColors.primaryColor)),
              Icon(showingMoreDetail?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color: GateManColors.primaryColor)
            ],
          ) ,


        ),
      ),
        showingMoreDetail?Container(
                 child: AnimatedSize(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:_moreDetail()),
                                      duration: Duration(milliseconds: 1000), vsync: this,
                                    ),
                                  ):Container(width: 0,height: 0,),
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
                      
                      
                                        } else if (validateRegExpPattern(_fullNameController.text, r'^([a-zA-Z]+)(\s[a-zA-Z]+)*$')==false){
                                           PaysmosmoAlert.showError(context: context,message: 'Invalid Name Input');
                                        }
                                  
                      
                                        else{
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
                                                                    // setState(() {
                                                                    //  _base64 =  response['qr_image_src'].toString().split(',')[1];
                                                                    // });
                                                                    openAlertBox(code: response['visitor']['qr_code']??'Nil', context: context, fullName: _fullNameController.text, screenshotController: screenshotController, arrival_date: model.arrival_date,);
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
                                                                    
                                                                    await PaysmosmoAlert.showSuccess(context: context,message: _fullNameController.text + ' as been added to your visitors list');
                                                                    print("qt image");
                                                                    print(response['qr_image_src']);
                                                                    print('${model.id} ::::::::id:::here');
                                                                    dynamic qr_image_src = await NewVisitorService.getQrImageSrcForVisitor(authToken: await authToken(context), visitorId: model.id);
                      
                                                                    if (qr_image_src is ErrorType){
                                                                      await PaysmosmoAlert.showError(context: context,message: '${GateManHelpers.errorTypeMap(qr_image_src)}\ncould not retrieve qr image');
                                                                      Navigator.pop(context);
                                                                    } else{
                                                                      Navigator.pop(context);
                                                                    openAlertBox(code:qr_image_src['qr_code']??'Nil', context: context, fullName: _fullNameController.text, screenshotController: screenshotController, arrival_date: model.arrival_date);
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
                      
                                              
                                            validateRegExpPattern(String text,String pattern) {
                                                  RegExp regExp = RegExp(pattern);
                                                  if (regExp.hasMatch(text)){
                                                    return true;
                                                  } else{
                                                    return false;
                                                  }
                      
                                            }
                      
                                           Widget buildCalendarOption({String day, String iconImageSrc,Function onPressed, dayInString}){
                                              return Container(
                                                child: InkWell(
                                                                            onTap: onPressed,
                                                                          child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                                  ImageIcon(
                                                   AssetImage('$iconImageSrc'),color: GateManColors.primaryColor,
                                                   size: 18,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text('$day', style: TextStyle(color: GateManColors.blackColor),),
                                                  )
                      
                                            ],
                      
                                          ),
                                          Text(
                                            '$dayInString'
                                          )
                      
                      
                      
                                      ],),
                                                ),
                                              );
                                            }
                      
                        _showCalendarDialog(BuildContext context) {
                          showDialog(context: context,
                          builder: (context){
                            return Dialog(
                            
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                          child: StatefulBuilder(
                                                            
                                                             builder: (BuildContext context, setState) {
                                                               return Container(
                                                                 
                                                                 
                                                                 decoration: BoxDecoration(
                                                                   borderRadius: BorderRadius.circular(20),
                                                                 ),
                                
                                    child:
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('${months[selectedDate!=null?selectedDate[1]-1:DateTime.now().month - 1].replaceRange(3, months[selectedDate!=null?selectedDate[1]-1:DateTime.now().month-1].length, '')} ${selectedDate!=null?selectedDate[0]:DateTime.now().day}'))),
                                        CustomDatePicker(
        onChanged: (date){
          print('date as been changed to ' + date);
          // _arrivalDateController.text = date;
          // arrivalDate=date;
          setState(() {
            selectedDate = date.split('/').map((f){
              return int.parse(f);
            }).toList();
          });
        },
        onSaved: (date){
        // _arrivalDateController.text = date;
        // arrivalDate=date;
        Navigator.pop(context);
        setParentState(date);
        toggleCalendarOptions(2);
                },
                
                now: DateTime.now(),minimumAllowedDate: DateTime.now(),
                includeInput: false,
                selectedDate: selectedDate,
                showingDetail: true, dateController: _arrivalDateController,
              ),
                                              ],
                                            ),
                                        );
                                                                     },
                                                                  ),
                                    );
                                  }
        
                                  );
                                
              }
        
          void setParentState(String date) {
            setState(() {
            selectedDate = date.split('/').map((f){
              return int.parse(f);
            }).toList();
          });
          }

}




