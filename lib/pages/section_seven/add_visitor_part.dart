import 'package:flutter/material.dart';
import 'package:gateapp/pages/section_seven/add_visitor_full.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:gateapp/widgets/VisitorsBox/VisitorsBox.dart';

class AddVisitorPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            Text('Kindly enter visitor\'s name below',
              style: TextStyle(color: GateManColors.textColor,fontSize: 14,fontWeight: FontWeight.w600),),
            SizedBox(height: 20,),
            CustomInputField(
              hint: 'Enter full name',
              prefix: Icon(Icons.person),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20,),
            Container(
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Add more details',style: TextStyle(color: GateManColors.primaryColor,fontSize: 12,fontWeight: FontWeight.w600),),
                    Icon(Icons.keyboard_arrow_down,size: 20,color: GateManColors.primaryColor,)
                  ],
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVisitorFull()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0),
              child: ActionButton(
                buttonText: 'Add',
                onPressed: (){

                },
                horizontalPadding: 0,),
            ),
            SizedBox(height: 40,),
            Text('Visitors',style: TextStyle(color: GateManColors.primaryColor,fontSize: 12,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            VisitorsBox(visitorsName: 'Michael Raggae', visitorsNumber: '09087675434'),
            VisitorsBox(visitorsName: 'Michael Raggae', visitorsNumber: '09087675434'),
            VisitorsBox(visitorsName: 'Michael Raggae', visitorsNumber: '09087675434'),

          ],
        ),
      ),
    );
  }
}
