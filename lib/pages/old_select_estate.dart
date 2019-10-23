import 'package:flutter/material.dart';
import 'package:gateapp/core/models/estate.dart';
import 'package:gateapp/core/models/estate_list.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/core/service/estate_service.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/Loader/loader.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/utils/constants.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String country, city, currentEstate, estateAddress;
  Model model = Model();
  bool isLoading = false;
  int selectedEstateId;

  List<String> _cities = ['Abuja'];
  List<String> _countries = ['Nigeria'];
  List<String> _allEstates = ['SunnyVille'];
  //Future<dynamic> _estates = EstateService.getAllEstates();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController searchEstateController =
      TextEditingController(text: '');
  List<EstateModel> filteredEstate;

  //get list of estates
  List<Estate> _estates = [];
  List<Estate> _filteredEstates = [];
  LoadingDialog dialog;

  @override
  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
    initApp();
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });
    Future.wait([
      EstateService.getAllEstates(
        authToken: await authToken(context),
      ),
    ]).then((res) {
      print(res);
      setState(() {
        _estates = res[0];

        print(_countries);
        print(_cities);
        print(_allEstates);

        isLoading = false;
      });
    });
  }

  //event listeners
  _onCountriesChanged(String value) {
    setState(() => country = value);
  }

  _onCitiesChanged(String value) {
    setState(() => city = value);
  }

  _onEstatesChanged(String value) {
    print(value);
    setState(() => currentEstate = value);
  }

  _onTextFieldChanged(String value) {
    setState(() {
      _filteredEstates = _estates.where((estate) {
        return estate.estateName == value;
      });
    });
  }

  _onSave() async {
    dialog.show();

    bool result = await EstateService.selectEstate(
      estateId: selectedEstateId,
      authToken: await authToken(context),
    );
    dialog.hide();

    dynamic getUserType = await userType(context);
    Map<user_type, String> mapUserTypeToPage = {
      user_type.RESIDENT: '/welcome-resident',
      user_type.GATEMAN: '/gateman_menu',
    };

    // if (await authToken(context) == null || await userType(context) == null) {
    //     Navigator.pushReplacementNamed(context, '/pager');
    //   } else {
    //     print(await authToken(context));
    //     Navigator.pushReplacementNamed(
    //         context, mapUserTypeToPage[await userType(context)]);
    //   }

    if (result) {
      PaysmosmoAlert.showSuccess(
              context: context, message: 'Estate Successfully Selected')
          .then((_) {
        // Navigator.pushReplacementNamed(context, mapUserTypeToPage[getUserType]);
        Navigator.pushReplacementNamed(context, '/gateman_menu');
      });
    } else {
      PaysmosmoAlert.showError(
              context: context, message: 'Could not seletced an Estate')
          .then((_) {
        Navigator.pushReplacementNamed(context, mapUserTypeToPage[getUserType]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ResidentUserProvider residentUserModel =
        Provider.of<ResidentUserProvider>(context, listen: false);
    AllEstateModel allEstates =
        Provider.of<AllEstateModel>(context, listen: false);
    // filteredEstate = allEstates.estates.where((estateModel) {
    //   return estateModel.estateName
    //       .toLowerCase()
    //       .contains(currentEstate.toLowerCase());
    // }).toList();
    UserTypeProvider userType =
        Provider.of<UserTypeProvider>(context, listen: false);
    return Form(
      key: _formkey,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            isLoading
                ? Loader.show()
                : ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
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
                        child: Text(
                          'Input your current location and estate to set you up',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      //Search an Estate
                      CustomTextFormField(
                        labelName: 'Select your Estate',
                        onChanged: _onTextFieldChanged,
                        hintText: 'Search by Estate name, City or Country',
                        prefixIcon: Icon(Icons.search),
                        controller: searchEstateController,
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.cancel),
                          onTap: () => searchEstateController.clear(),
                        ), onSaved: (String j) {}, validator: (String j) {return j;},
                      ),

                      _filteredEstates != null && _filteredEstates.length > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 4),
                              height: filteredEstate.length > 4
                                  ? 200
                                  : filteredEstate.length * 38.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: GateManColors.primaryColor)),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          _filteredEstates[index].estateName),
                                    ),
                                    onTap: () {
                                      Estate est = _filteredEstates[index];
                                      //set estate id to controller
                                      setState(() {
                                        searchEstateController.text =
                                            est.estateName +
                                                ', ' +
                                                est.city +
                                                ', ' +
                                                est.country;
                                        selectedEstateId = est.estateId;
                                      });
                                    },
                                  );
                                },
                                itemCount: filteredEstate.length,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: GateManColors.primaryColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Estate Not Found",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                      //Select Country
                      CustomDropdownButton(
                        label: 'Select Country',
                        hintText: _countries.first,
                        value: country ?? _countries.first,
                        onChanged: _onCountriesChanged,
                        items: _countries.map(
                          (String value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                      ),

                      //Select City
                      CustomDropdownButton(
                        label: 'Select City',
                        hintText: _cities.first,
                        value: city ?? _cities.first,
                        onChanged: _onCitiesChanged,
                        items: _cities.map(
                          (String value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                      ),

                      //Select Esatte
                      CustomDropdownButton(
                        label: 'Select your Estate',
                        hintText: _allEstates.first,
                        value: currentEstate ?? _allEstates.first,
                        onChanged: _onEstatesChanged,
                        items: _allEstates.map(
                          (String value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                      ),

                      // filteredEstate == null || filteredEstate.length < 1
                      Stack(
                        children: <Widget>[
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Text('Could not find my Estate?',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: GateManColors.textColor,
                                      fontWeight: FontWeight.w600)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEstate()),
                              );
                            },
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 240),
                              child: Text('Add New',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEstate()),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 90.0),

                      //Save Button
                      ActionButton(
                        buttonText: 'Continue',
                        onPressed: selectedEstateId != null ? _onSave : null,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
