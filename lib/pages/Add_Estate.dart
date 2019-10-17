import 'package:flutter/material.dart';
import 'package:gateapp/core/models/estate_list.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/core/service/estate_service.dart';

class AddEstate extends StatefulWidget {
  @override
  _AddEstateState createState() => _AddEstateState();
}

class _AddEstateState extends State<AddEstate> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  //Model model = Model();
  EstateModel model = EstateModel();

  List<String> _countries = ['Nigeria', 'South Africa', 'China'];
  List<String> _cities = ['Lagos', 'Abuja', 'Imo'];
  List<String> _estates = ['CBS Esate', 'Lux Eco', '1000 Units'];

  @override
  void initState() {
    model.city = _cities[0];
    model.country = _countries[0];
    super.initState();
  }

  String country, city, estateAddress, estateName;

  //event listeners
  _onCountriesChanged(String value) {
    model.country = value;
    setState(() => country = value);
  }

  _onCitiesChanged(String value) {
    model.city = value;
    setState(() => city = value);
  }

  _onEstateAddressChanged(String value) {
    model.estateAddress = value;
    setState(() => estateAddress = value);
  }

  _onEsatesNameChanged(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    ResidentUserProvider residentUserModel =
        Provider.of<ResidentUserProvider>(context, listen: false);
    AllEstateModel allEstates =
        Provider.of<AllEstateModel>(context, listen: false);
    return Form(
      key: _formkey,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Add New Estate',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.green,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    'Input the current location and estate you are adding',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                ),

                //Enter Estate name
                CustomTextFormField(
                  controller: nameController,
                  labelName: ' Estate Name',
                  hintText: 'Enter Estate Name',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Estate name is empty';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.estateName = value;
                  },
                  onChanged: (String value) {
                    model.estateName = value;
                  },
                ),
                //Enter Address
                CustomTextFormField(
                  controller: addressController,
                  labelName: ' Estate Address',
                  hintText: 'Enter Estate Address',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Estate Address is empty';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.estateAddress = value;
                  },
                  onChanged: (String value) {
                    model.estateAddress = value;
                  },
                ),
                //Select City
                CustomDropdownButton(
                  label: 'Select City',
                  hintText: _cities.first,
                  value: city ?? _cities.first,
                  onChanged: _onCitiesChanged,
                  items: _cities.map(
                    (String city) {
                      return DropdownMenuItem(
                        child: Text(city),
                        value: city,
                      );
                    },
                  ).toList(),
                ),
                //Select Country
                CustomDropdownButton(
                  label: 'Select Country',
                  hintText: _countries.first,
                  value: country ?? _countries.first,
                  onChanged: _onCountriesChanged,
                  items: _countries.map(
                    (String country) {
                      return DropdownMenuItem(
                        child: Text(country),
                        value: country,
                      );
                    },
                  ).toList(),
                ),

                SizedBox(height: 51.0),

                //Save Button
                ActionButton(
                  buttonText: 'Add',
                  onPressed: () async{
                    LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                    dialog.show();

                    try {
                      if (_formkey.currentState.validate()) {
                        model.estateName = nameController.text;
                        model.estateAddress = addressController.text;

                        dynamic response = await EstateService.addEstate(
                            estateName: nameController.text,
                            city: city,
                            country: country);

                        print(response);

                        Navigator.pop(context);

                        PaysmosmoAlert.showSuccess(context: context,message: "Estate Added Successfull",);

                        allEstates.addEstate(model);
                        residentUserModel.setResidentEstate(
                            residentEstate: model);
                        print(allEstates.estates);
                      Navigator.pushNamed(context, '/select-estate');
                      }
                    } catch(error){
                      print("Here : " + error);
                      Navigator.pop(context);
//                      PaysmosmoAlert.showError(context: context,message: error.toString(),);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
