import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:intl/intl.dart';

class EditInfo extends StatefulWidget {
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  Widget build(BuildContext context) {
    String _name, _phoneNumber, _otherNumber, _dutyTime;

    List<String> _duties = ['Morning', 'Afternoon', 'Evening'];

    //event listeners
    _onDutyChanged(String value) {
      setState(() => _dutyTime = value);
    }

    //date picker
    Future<Null> _selectDate() async {
      DateTime initialDate = DateTime.now();
      DateTime startDate = DateTime.now();
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));

      String formatted = DateFormat('y/MM/dd').format(picked);
      // if (picked != null && picked != initialDate) {
      //   setState(() {
      //     startDate = formatted;
      //   });
      // }
    }

    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Edit Info'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          //Name
          CustomTextFormField(
            labelName: 'Name',
            onSaved: (str) => _name = str,
            validator: (str) => str.isEmpty ? 'Name cannot be empty' : null,
            initialValue: 'Idris Abdulkareem',
          ),

          //Phone Number
          CustomTextFormField(
            labelName: 'Phone Number',
            onSaved: (str) => _phoneNumber = str,
            validator: (str) =>
                str.isEmpty ? 'Phone Number cannot be empty' : null,
            initialValue: '0812345678',
          ),

          //Other Number
          CustomTextFormField(
            labelName: 'Other Number',
            onSaved: (str) => _phoneNumber = str,
            validator: (str) =>
                str.isEmpty ? 'Other Number cannot be empty' : null,
            initialValue: '0812345678',
          ),

          //Start date
          CustomTextFormField(
            labelName: 'Start Date',
            onSaved: (str) => _phoneNumber = str,
            validator: (str) =>
                str.isEmpty ? 'Other Number cannot be empty' : null,
            initialValue: 'Monday 23rd, Sept, 2019',
            suffixIcon: GestureDetector(
              onTap: () {
                _selectDate();
              },
              child: Icon(
                Icons.calendar_today,
                size: 20.0,
                color: GateManColors.primaryColor,
              ),
            ),
          ),

          //Select Duty Time
          CustomDropdownButton(
            label: 'Duty Time',
            hintText: _duties.first,
            value: _dutyTime ?? _duties.first,
            onChanged: _onDutyChanged,
            items: _duties.map((String duty) {
              return DropdownMenuItem(
                child: Text(duty),
                value: duty,
              );
            }).toList(),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 38.0, vertical: 9.0),
            child: ActionButton(
              buttonText: 'Save',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
