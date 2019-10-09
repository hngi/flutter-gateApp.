import 'package:flutter/material.dart';
import 'package:gateapp/core/models/user.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  final _formkey = GlobalKey<FormState>();
  Model model = Model();

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
    return Form(
      key: _formkey,
          child: Scaffold(
        body: Stack(children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text('Select Your Estate',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.green,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child:
                    Text('Input your current location and estate to set you up',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        )),
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

              SizedBox(height: 90.0),

              //Save Button
              ActionButton(
                buttonText: 'Continue',
                onPressed: () {},
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 430.0, left: 110),
            child: Text('Could not find my Estate?',
                style: TextStyle(
                    fontSize: 13.0,
                    color: GateManColors.textColor,
                    fontWeight: FontWeight.w600)),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 430.0, left: 270),
              child: Text('Add New',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w700)),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEstate()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
