import 'package:flutter/material.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:gateapp/widgets/DashedRectangle/dashed_rectangle.dart';

class AddVisitorFull extends StatefulWidget {
  @override
  _AddVisitorFullState createState() => _AddVisitorFullState();
}

class _AddVisitorFullState extends State<AddVisitorFull> {
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
          onTap: (){
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
                padding: const EdgeInsets.only(top:20.0,bottom: 20),
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
                padding: const EdgeInsets.only(top:20.0,bottom: 20),
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
                padding: const EdgeInsets.only(top:20.0,bottom: 15),
                child: Text(
                  'Car Plate Number (Optional)',
                  style: TextStyle(
                      color: GateManColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
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
                padding: const EdgeInsets.only(top:20.0,bottom: 16),
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
                  onPressed: () {},
                  horizontalPadding: 0,
                ),
              ),




            ],


          ),
        ),
      ),
    );
  }
}
