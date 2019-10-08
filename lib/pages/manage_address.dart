import 'package:flutter/material.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  List<String> _countries = ['Nigeria', 'South Africa', 'China'];
  List<String> _cities = ['Lagos', 'Abuja', 'Imo'];
  List<String> _estates = ['CBS Esate', 'Lux Eco', '1000 Units'];

  String country, city, estate, flatNumber;

  //event listeners
  _onCountriesChanged(String value) {
    setState(() => country = value);
  }

  _onCitiesChanged(String value) {
    setState(() => city = value);
  }

  _onEstatesChanged(String value) {
    setState(() => estate = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Manage Address'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
                'Update your flat number and if you have moved to another estate update the current location and Estate name',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.0)),
          ),

          //Select Country
          CustomDropdownButton(
            label: 'Select Country',
            hintText: _countries.first,
            value: country ?? _countries.first,
            onChanged: _onCountriesChanged,
            items: _countries.map((String country) {
              return DropdownMenuItem(
                child: Text(country),
                value: country,
              );
            }).toList(),
          ),

          //Select City
          CustomDropdownButton(
            label: 'Select City',
            hintText: _cities.first,
            value: city ?? _cities.first,
            onChanged: _onCitiesChanged,
            items: _cities.map((String city) {
              return DropdownMenuItem(
                child: Text(city),
                value: city,
              );
            }).toList(),
          ),

          //Select Estate
          CustomDropdownButton(
            label: 'Select your Estate',
            prefixIcon: Icon(Icons.search),
            hintText: _estates.first,
            value: estate ?? _estates.first,
            onChanged: _onEstatesChanged,
            items: _estates.map((String estate) {
              return DropdownMenuItem(
                child: Text(estate),
                value: estate,
              );
            }).toList(),
          ),

          //Enter Flat Number

          CustomTextFormField(
            labelName: 'Flat Number',
            onSaved: (str) => flatNumber = str,
            validator: (str) => str.isEmpty ? 'Flat Number is required' : null,
          ),

          SizedBox(height: 22.0),

          //Save Button
          ActionButton(
            buttonText: 'Save',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
