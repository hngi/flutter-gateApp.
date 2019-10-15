import 'package:flutter/material.dart';
import 'package:gateapp/pages/section_seven/add_visitor_full.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:gateapp/widgets/CustomDatePicker/custom_date_picker.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:gateapp/widgets/DashedRectangle/dashed_rectangle.dart';
import 'package:gateapp/widgets/VisitorsBox/VisitorsBox.dart';

class AddVisitorPart extends StatefulWidget {
  @override
  _AddVisitorPartState createState() => _AddVisitorPartState();
}

class _AddVisitorPartState extends State<AddVisitorPart> with TickerProviderStateMixin  {
  bool showingMoreDetail = false;
  bool morningChecked=true;
  bool afternoonChecked=false;
  bool eveningChecked=false;
  TextEditingController textEditingController = TextEditingController();

  

  void toggleShowingMoreDetail() {
    setState(() {
      showingMoreDetail = !showingMoreDetail;
    });
  }

  openAlertBox() {
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
                            padding: const EdgeInsets.only(top: 20.0),
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
                                  'Mr Seun Adeniyi',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF4f4f4f)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Image.asset(
                              'assets/images/qr.png',
                            ),
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
                                  '4561WT',
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
                          Padding(
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
      GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add more details',
              style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.keyboard_arrow_up,
              size: 20,
              color: GateManColors.primaryColor,
            )
          ],
        ),
        onTap: () {
          toggleShowingMoreDetail();
        },
      ),
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
      CustomDatePicker(onChanged: (date){
        textEditingController.text = date;
      }, onSaved: (date){
        textEditingController.text = date;
      },now: DateTime.now(),minimumAllowedDate: DateTime.now(),
      includeInput: true,
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
        child: DashedRectangle(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/ei-image.png'),
              Text(
                'Upload Visitor\'s Image',
                style: TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
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
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: AnimatedSize(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: showingMoreDetail
                      ? _moreDetail()
                      : <Widget>[
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Add more details',
                                    style: TextStyle(
                                        color: GateManColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: GateManColors.primaryColor,
                                  )
                                ],
                              ),
                              onTap: () {
                                toggleShowingMoreDetail();
                              })
                        ],
                ),
                duration: Duration(milliseconds: 1000), vsync: this,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ActionButton(
                buttonText: 'Add',
                onPressed: () {
                  openAlertBox();
                },
                horizontalPadding: 0,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Visitors',
              style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            VisitorsBox(
                visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
            VisitorsBox(
                visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
            VisitorsBox(
                visitorsName: 'Michael Raggae', visitorsNumber: '09087675434',visitorsCategory: 'Family',),
          ],
        ),
      ),
    );
  }

}


