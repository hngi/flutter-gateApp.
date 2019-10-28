import 'dart:core';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/core/service/visitor_service_new.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:xgateapp/widgets/CustomDatePicker/custom_date_picker.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';
import 'package:xgateapp/widgets/VisitorsBox/VisitorsBox.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
class AddVisitorPart extends StatefulWidget {
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

  String _fullname;
  
  File imageFile;

  String _base64;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController(text:'');
    _carPlateNumberController = TextEditingController(text:'');
    _purposeController=TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _carPlateNumberController.dispose();
    _purposeController.dispose();
  }

  List<File> _images;

  File image;

  Future shareInvite() async{
    // final ByteData bytes=await rootBundle.load('assets/images/qr.png');
    Uint8List bytes = base64.decode(_base64);
    print('sharing');
    await Share.file('Estate Invite',
        'qr.png',
        bytes.buffer.asUint8List(),
        'image/png',
        text: 'Show this at the security gate.');


    //Share.text('Visitor Invite', 'This is my text to share with other applications.', 'text/plain');
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
          return AlertDialog(
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
                                'Visitor added successfully',
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
                              child: Image.memory(base64.decode(_base64)),
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
          );
        });
  }

  List<Widget> _moreDetail() {
    return [
      // GestureDetector(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Add more details',
      //         style: TextStyle(
      //             color: GateManColors.primaryColor,
      //             fontSize: 12,
      //             fontWeight: FontWeight.w600),
      //       ),
      //       Icon(
      //         Icons.keyboard_arrow_up,
      //         size: 20,
      //         color: GateManColors.primaryColor,
      //       )
      //     ],
      //   ),
      //   onTap: () {
      //     toggleShowingMoreDetail();
      //   },
      // ),
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
      // CustomInputField(
      //   textEditingController: textEditingController,
      //   hint: 'Enter arrival date',
      //   prefix: Icon(Icons.calendar_today),
      //   keyboardType: TextInputType.datetime,
      // ),
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
                image==null?
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
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: AnimatedSize(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:_moreDetail() //showingMoreDetail
                      // ? _moreDetail()
                      // : <Widget>[
                      //     GestureDetector(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: <Widget>[
                      //             Text(
                      //               'Add more details',
                      //               style: TextStyle(
                      //                   color: GateManColors.primaryColor,
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //             Icon(
                      //               Icons.keyboard_arrow_down,
                      //               size: 20,
                      //               color: GateManColors.primaryColor,
                      //             )
                      //           ],
                      //         ),
                      //         onTap: () {
                      //           toggleShowingMoreDetail();
                      //         })
                      //   ],
                ),
                duration: Duration(milliseconds: 1000), vsync: this,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ActionButton(
                buttonText: 'Add',
                onPressed: () async {
                  print(_arrivalDateController.text);
                  // commented out because it was buggy
                  // final date=DateFormat('yyyy-MM-dd').format(DateFormat().add_yMd().parse(_arrivalDateController.text));
                  final date=_arrivalDateController.text.split('/').reversed.join('-');
                  
                  print(date);

                  print('FULL NAME '+_fullNameController.text);
                  print('CAR PLATE: '+_carPlateNumberController.text);
                  print('PURPOSE: '+_purposeController.text);
                  print('ARRIVAL DATE: $date');
                  print('IMAGE PATH: $image');


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
                    LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                    dialog.show();
                    dynamic response = await NewVisitorService.addVisitor(
                      name: _fullNameController.text,
                      arrivalDate: date.isEmpty? DateFormat('yyyy-MM-dd').format(DateTime.now()):date,
                      carPlateNo: _carPlateNumberController.text,
                      purpose: _purposeController.text.isEmpty? 'none':_purposeController.text,
                      status: '8',
                      estateId: '7',//image: image==null?null:image.path.toString(),
                      authToken: await authToken(context),
                      image: image??null,
                      visitingPeriod: this.morningChecked?'morning':this.afternoonChecked?'afternoon':'Evening'
                    );

                    print(response);
                    if (response is ErrorType){
                      Navigator.pop(context);


                      PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));
                    
                    } else{
                        // print(response);
                        dialog.hide();
                        getVisitorProvider(context).addVisitorModel(VisitorModel.fromJson(response['visitor']));
                       loadInitialVisitors(context,skipAlert:true);
                        
                        PaysmosmoAlert.showSuccess(context: context,message: _fullNameController.text + ' as been added to your visitors list');
                        print("qt image");
                        print(response['qr_image_src']);
                        setState(() {
                         _base64 =  response['qr_image_src'].toString().split(',')[1];
                        });
                        openAlertBox(response['visitor']['qr_code']??'Nil');
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

}


