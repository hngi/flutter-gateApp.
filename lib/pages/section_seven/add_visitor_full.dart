import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';

class AddVisitorFull extends StatefulWidget {
  @override
  _AddVisitorFullState createState() => _AddVisitorFullState();
}

class _AddVisitorFullState extends State<AddVisitorFull> {

  final Color myColor=Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: GateManColors.primaryColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Visitor',
          style: TextStyle(color: GateManColors.primaryColor, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  'Kindly enter visitor\'s name below',
                  style: TextStyle(
                      color: GateManColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              CustomInputField(
                hint: 'Enter full name',
                prefix: Icon(Icons.person),
                keyboardType: TextInputType.text,
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
              CustomInputField(
                hint: 'Enter arrival date',
                prefix: Icon(Icons.calendar_today),
                keyboardType: TextInputType.datetime,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomCheckBox(text: 'Morning'),
                    CustomCheckBox(text: 'Afternoon'),
                    CustomCheckBox(text: 'Evening'),
                  ],
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
            ],
          ),
        ),
      ),
    );


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

}

