import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/estate_list.dart';
import 'package:xgateapp/core/models/old_user.dart';
import 'package:xgateapp/core/service/estate_service.dart';
import 'package:xgateapp/providers/resident_user_provider.dart';
import 'package:xgateapp/utils/FlushAlert/flush_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
// import 'package:xgateapp/core/service/estate_service.dart';

class AddEstate extends StatefulWidget {
  @override
  _AddEstateState createState() => _AddEstateState();
}

class _AddEstateState extends State<AddEstate> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  //Model model = Model();
  EstateModel model = EstateModel();

  List<String> _countries = ['Nigeria', 'South Africa', 'China'];
  List<String> _cities = ['Lagos', 'Abuja', 'Imo'];
  //Future<dynamic> _estates = EstateService.addEstate(estateName: null, city: null, country: null);

  String _estateName, _address, _country, _city;

  _onSaved() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
      dialog.show();

      var res = await EstateService.addEstate(
        city: _city,
        country: _country,
        estateName: _estateName,
        address: _address,
      );

      dialog.hide();

      if (res == ErrorType.network) {
        FlushAlert.show(
          context: context,
          message: 'No Internet Connection!',
          isError: true,
        );
      } else if (res == ErrorType.timeout) {
        //Show Timeout error
        FlushAlert.show(
          context: context,
          message: 'Check your Internet connection!',
          isError: true,
        );
      } else if (res == ErrorType.estate_country) {
        //Show Timeout error
        FlushAlert.show(
          context: context,
          message: 'Country must be provided',
          isError: true,
        );
      } else if (res == ErrorType.estate_address) {
        //Show Timeout error
        FlushAlert.show(
          context: context,
          message: 'Address must be provided',
          isError: true,
        );
      } else if (res == ErrorType.estate_city) {
        //Show Timeout error
        FlushAlert.show(
          context: context,
          message: 'City must be provided',
          isError: true,
        );
      } else if (res == ErrorType.estate_estate_name) {
        //Show Timeout error
        FlushAlert.show(
          context: context,
          message: 'Estate name must be provided',
          isError: true,
        );
      } else if (res == ErrorType.generic) {
        //Show something went wrong error
        FlushAlert.show(
          context: context,
          message: 'Something went wrong, try again!',
          isError: true,
        );
      } else {
        //login

        FlushAlert.show(
          context: context,
          message: 'Estate added successfully',
          isError: false,
        ).then((_) {
          Navigator.of(context).pushReplacementNamed('/select-estate');
        });
      }
    }
  }

  @override
  void initState() {
    model.city = _cities[0];
    model.country = _countries[0];
    super.initState();
  }

  _initView() {}

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
      key: _formKey,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: ListView(
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

                  //Enter Country
                  CustomTextFormField(
                    labelName: 'Country',
                    hintText: 'Enter Country',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Country is empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _country = value;
                    },
                  ),

                  //Enter Address
                  CustomTextFormField(
                    controller: addressController,
                    labelName: 'City',
                    hintText: 'Enter City',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'City is empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _city = value;
                    },
                  ),

                  //Enter Estate name
                  CustomTextFormField(
                    labelName: ' Estate Name',
                    hintText: 'Enter Estate Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Estate name is empty';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _estateName = value;
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
                      _address = value;
                    },
                  ),

                  SizedBox(height: 51.0),

                  //Save Button
                  ActionButton(
                    buttonText: 'Add',
                    onPressed: _onSaved,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
